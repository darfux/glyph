module CoffeeBag
  class Preprocessor < Sprockets::DirectiveProcessor
    # A typical prepared data is like below:

    #   #= require app_name/klass
    #   ep0 = fetch 'app_name.klass'
    #
    #   root = exports ? this
    #
    #   InternalKlass = null
    #   $(document).ready ->
    #     InternalKlass = fetch('app_name.self_bag.InternalKlass')
    #
    #   class Test
    #     @test: ->
    #       123
    #
    #   bag 'app_name.self_bag.Test', Test

    def prepare
      if file.include? app_asset_path and file.include? '.coffee' # avoid modifying rails default files
        fill(file.include? bag_path)
      end
      super
    end

    protected

      def fill(withbag)
        requires = []
        fetch_statements = []
        filtered_data = ""
        @data.each_line do |l|
          if l[0..7]=='#-import'
            package = l.split[1]
            klass = package.split('.').last
            path = package.split('.')[0..-2].join('/')+"/#{klass.underscore}"
            requires.push "#= require #{path}\n"
            fetch_statements.push "#{klass} = fetch '#{package}'\n"
            next
          end
          filtered_data<<l
        end
        require_statements = requires.join + fetch_statements.join # ensure that the requires are on the top of file
        @data = (
          header = require_statements + root_statement
          if withbag
            header+internal_statements+filtered_data+bag_statement
          else
            header+filtered_data
          end
        )
      end

      def internal_statements
        current_file_name = file.split('/')[-1]
        internal_klasses = []
        orgdir = Dir.pwd
        Dir.chdir file.split('/')[0..-2].join('/')
        package = file.split(app_asset_path)[1].split('/')[0..-2].join('.')
        Dir.foreach('.') do |f|
          next if File.directory?(f)
          next if f==current_file_name
          internal_klasses.push f.split('.')[0].classify
        end
        return "" if internal_klasses.empty?
        statements = "\n"+internal_klasses.join(' = ')+" = null\n"
        statements<<"$(document).ready ->\n"
        internal_klasses.each do |k|
          statements<<"\t#{k} = fetch('#{package}.#{k}')\n"
        end
        statements<<"\n"
        statements
      end

      def root_statement
        "\nroot = exports ? this\n"
      end

      def bag_statement
        bag_path = file.split(app_asset_path)[1].split('.')[0]
        tmp = bag_path.split('/')
        klass = tmp.last.classify
        bag = tmp[0..-2].join('.') + ".#{klass}"
        "\nbag '#{bag}', #{klass}\n" #add a '\n' at head to avoid concat with oringinal file
      end

      def app_name
        @app_name ||= Rails.application.class.to_s.split("::").first.downcase
      end

      def app_asset_path
        @app_asset_path ||= Rails.root.to_s+"/app/assets/javascripts/"
      end

      def bag_path
        app_asset_path+app_name
      end
  end
end