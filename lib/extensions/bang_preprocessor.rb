module BangBang
  class Processor < Sprockets::DirectiveProcessor
    def prepare
      if file.include? app_asset_path and file.include? '.coffee' # avoid modifying rails default files
        handle_import(file.include? app_asset_path+app_name)
      end
      super
    end
    private
      def handle_import(withbag)
        requires = []
        fetch_statements = []
        tmp_data = ""
        @data.each_line do |l|
          if l[0..7]=='#-import'
            package = l.split[1]
            klass = package.split('.').last
            path = package.split('.')[0..-2].join('/')+"/#{klass.underscore}"
            requires.push "#= require #{path}\n"
            fetch_statements.push "#{klass} = fetch '#{package}'\n"
            next
          end
          # if l.include?("class #{klass}") && @hasbag != false
          #   @hasbag = true
          # end
          tmp_data<<l
        end
        tmp = requires.join + fetch_statements.join # ensure that the requires are on the top of file
        @data = (
          if withbag
            internal_statements = handle_internal
            tmp+internal_statements+tmp_data
          else
            tmp+tmp_data+"\n#-nobag\n"
          end
        )
      end
      def handle_internal
        current_file_name = file.split('/')[-1]
        # dir = Dir.new()
        internal_klasses = []
        orgdir = Dir.pwd
        Dir.chdir file.split('/')[0..-2].join('/')
        package = file.split(app_asset_path)[1].split('/')[0..-2].join('.')
        Dir.foreach('.') do |f|
          next if File.directory?(f)
          next if f==current_file_name
          internal_klasses.push f.split('.')[0].classify
        end
        statements = "\n"+internal_klasses.join(' = ')+" = null\n"
        statements<<"$(document).ready ->\n"
        internal_klasses.each do |k|
          statements<<"\t#{k} = fetch('#{package}.#{k}')\n"
        end
        statements<<"\n"
        statements
      end
      def app_name
        @app_name ||= Rails.application.class.to_s.split("::").first.downcase
      end
      def app_asset_path
        @app_asset_path ||= Rails.root.to_s+"/app/assets/javascripts/"
      end
  end
end