require 'tilt/template'
require 'coffee_script'
require 'pry'
module BangBang
  class Template < Tilt::CoffeeScriptTemplate

    def evaluate(scope, locals, &block)
      if file.include? app_asset_path # avoid modifying rails default files
        add_root
        add_bag_info
      end
      # print data
      super
    end

    private
      def add_root
        @data = "root = exports ? this\n"+@data
      end
      def add_bag_info
        return if data.each_line.to_a.last.chomp.chomp == '#-nobag'
        bag_path = file.split(app_asset_path)[1].split('.')[0]
        tmp = bag_path.split('/')
        klass = tmp.last.classify
        bag = tmp[0..-2].join('.') + ".#{klass}"
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