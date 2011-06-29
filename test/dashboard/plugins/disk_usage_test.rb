require 'test/unit'
require 'dashboard'

module Dashboard
  module Plugins
    class DiskUsageTest < Test::Unit::TestCase
      def test_load_averages
        plugin = DiskUsage.new
        e = begin; raise StandardError, 'foo'; rescue; $! ; end
        assert_kind_of Report, report = plugin.run
        plugin.error e
        report_again = JSON JSON report
        assert_match(/_abs\Z/, report_again.values[0][:name].to_s)
        assert_match(/_rel\Z/, report_again.values[1][:name].to_s)
        assert_kind_of e.class, report_again.exception
      end
    end
  end
end

