require 'test/unit'
require 'dashboard'

module Dashboard
  module Plugins
    class LoadAveragesTest < Test::Unit::TestCase
      def test_load_averages
        plugin = LoadAverages.new
        e = begin; raise StandardError, 'foo'; rescue; $! ; end
        assert_kind_of Report, report = plugin.run
        plugin.error e
        report_again = JSON JSON report
        assert_kind_of Float, report_again.values[0][:value]
        assert_kind_of Float, report_again.values[1][:value]
        assert_kind_of Float, report_again.values[2][:value]
        assert_kind_of e.class, report_again.exception
      end
    end
  end
end
