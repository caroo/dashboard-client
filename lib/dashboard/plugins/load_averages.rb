require 'sys/cpu'

module Dashboard
  module Plugins
    class LoadAverages < Dashboard::Plugin

      def build_report
        avg = Sys::CPU.load_avg
        report :last_minute, avg[0]
        report :last_five_minutes, avg[1]
        report :last_fifteen_minutes, avg[2]
      end
    end
  end
end
