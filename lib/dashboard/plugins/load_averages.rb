require 'cpu'

module Dashboard
  module Plugins
    class LoadAverages < Dashboard::Plugin

      def build_report
        load = CPU.load
        report :last_minute, load.last_minute, :num_processors => load.num_processors
        report :last_5_minutes, load.last_5_minutes, :num_processors => load.num_processors
        report :last_15_minutes, load.last_15_minutes, :num_processors => load.num_processors
      end
    end
  end
end
