require 'tilt/template'
require 'coffee_script'
require 'pry'
module BangBang
  class Template < Tilt::CoffeeScriptTemplate

    def evaluate(scope, locals, &block)
      if file.include? app_asset_path # avoid modifying rails default files
        handle_import
        add_root
        add_bag_info unless @nobag
      end
      # print data
      super
    end

    private
      def add_root
        @data = "root = exports ? this\n"+@data
      end
      def handle_import
        tmp_data = ""
        @data.each_line do |l|
          if l.chomp.chomp=='#-nobag'
            @nobag = true
            next
          end
          tmp_data<<l
        end
        @data = tmp_data
        #tmp = requires.join + fetch_statements.join # ensure taht the requires are on the top of file
      end
      def add_bag_info
        bag_path = file.split(app_asset_path)[1].split('.')[0]
        tmp = bag_path.split('/')
        klass = tmp.last.classify
        bag = "#{app_name}." + tmp[0..-2].join('.') + ".#{klass}"
        @data+="\nbag '#{bag}', #{klass}" #add a '\n' at head to avoid concat with oringinal file
      end
      def app_name
        @app_name ||= Rails.application.class.to_s.split("::").first.downcase
      end
      def app_asset_path
        @app_asset_path ||= Rails.root.to_s+"/app/assets/javascripts/"
      end
  end
end