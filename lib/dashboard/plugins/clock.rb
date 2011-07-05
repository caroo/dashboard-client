module Dashboard
  module Plugins
    class Clock < Dashboard::Plugin
      option :alarm_time_period

      def build_report
        period = alarm_time_period.is_a?(Range) ? [ alarm_time_period ] : alarm_time_period
        for p in period
          p = DateTime.parse(p.begin)..DateTime.parse(p.end)
          report :alarm, p.include?(report.timestamp)
        end
      end
    end
  end
end
