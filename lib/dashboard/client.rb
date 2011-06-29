require 'fileutils'

module Dashboard
  class Client
    include FileUtils

    def initialize(config)
      @config = config
    end

    attr_reader :config

    attr_accessor :debugging

    def run
      for plugin in @config
        plugin.client = self
        report = plugin.run
        mkdir_p plugin.path('values')
        File.open(report.filename, 'w') do |out|
          json = JSON(report)
          debugging and warn json
          out.puts json
        end
      end
    end
  end
end
