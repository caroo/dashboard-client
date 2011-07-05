require 'fileutils'

module Dashboard
  class Client
    include FileUtils

    def initialize(config)
      @config = config
      for plugin in @config
        plugin.client = self
      end
    end

    def self.for_config_file(filename)
      config = Config.interpret_config_file filename
      new(config)
    end

    attr_reader :config

    attr_accessor :debugging

    attr_accessor :dry_run

    def run
      reports = []
      for plugin in @config
        plugin.client = self
        report = plugin.run
        reports << report
        plugin.persistent or next
        dry_run and next
        mkdir_p plugin.path('values')
        File.open(report.filename, 'w') do |out|
          json = JSON(report)
          debugging and warn json
          out.puts json
        end
      end
      reports
    end

    def run_plugin(plugin_name)
      if plugin = @config.find { |plugin| plugin.name == plugin_name }
        plugin.run
      end
    end

    def pending
      config.inject([]) do |a, plugin|
        a.concat Dir[plugin.path('values', '*.json')]
      end
    end
  end
end
