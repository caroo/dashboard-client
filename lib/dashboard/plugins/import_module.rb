require 'dashboard/plugins/database_plugin'

module Dashboard
  module Plugins
    class ImportModule < DatabasePlugin
      STATES = [ :failed, :produced, :aggregated, :invalid, :consumed, :finished, :rejected, ]

      def build_report
        super
        for state in STATES
          report :"import_state_#{state}", how_many?(%{SELECT COUNT(*) FROM import_jobs WHERE state = '#{state}'})
        end
      end
    end
  end
end
