require 'yaml'
require 'active_record'

module Dashboard
  module Plugins
    class DatabasePlugin < Dashboard::Plugin
      option :database_config
      option :environment, 'production'

      def build_report
        configure_db
      end

      def configure_db
        database_config and File.readable?(database_config) or
          raise MissingPluginOption, "option database_config required for plugin"
        config = YAML.load_file(database_config)
        ActiveRecord::Base.establish_connection(config[environment])
        @db = ActiveRecord::Base.connection
      end

      def how_many?(sql)
        @db.select_rows(sql).full? { |count| count.first.first.to_i }
      end
    end
  end
end
