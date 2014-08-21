module BangBang
  class Processor < Sprockets::DirectiveProcessor
    def prepare
      if file.include? app_asset_path # avoid modifying rails default files
        handle_import
      end
      super
    end
    private
      def handle_import
        requires = []
        fetch_statements = []
        tmp_data = ""
        @data.each_line do |l|
          if l[0..7]=='#-import'
            package = l.split[1]
            klass = package.split('.').last
            path = package[app_name.length+1..-1].split('.')[0..-2].join('/')+"/#{klass.underscore}"
            requires.push "#= require #{path}\n"
            fetch_statements.push "#{klass} = fetch '#{package}'\n"
            next
          end
          tmp_data<<l
        end
        tmp = requires.join + fetch_statements.join # ensure taht the requires are on the top of file
        @data = tmp+tmp_data
      end
      def app_name
        @app_name ||= Rails.application.class.to_s.split("::").first.downcase
      end
      def app_asset_path
        @app_asset_path ||= Rails.root.to_s+"/app/assets/javascripts/"
      end
  end
end