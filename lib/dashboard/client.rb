require 'fileutils'
require 'spruz/write'

module Dashboard
  class Client
    include FileUtils
    include Spruz::Write

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

    def run(plugin_names = nil)
      reports = []
      for plugin in @config
        if plugin_names.full?
          plugin_names.include?(plugin.name) or next
        end
        plugin.client = self
        report = plugin.run
        reports << report
        plugin.persistent or next
        dry_run and next
        mkdir_p plugin.path('values')
        write(report.filename) do |out|
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

    def pending(plugin_names = nil)
      config.inject([]) do |a, plugin|
        if plugin_names.full?
          plugin_names.include?(plugin.name) or next a
        end
        a.concat Dir[plugin.path('values', '*.json')]
      end
    end
  end
end
