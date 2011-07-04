require 'cpu'

module Dashboard
  module Plugins
    class CpuUsage < Dashboard::Plugin

      def build_report
        processor = CPU.sum_usage_processor
        report :cpu_usage, processor.usage.percentage
      end
    end
  end
end
