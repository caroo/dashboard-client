require 'mocha'
require 'test/unit'
require 'dashboard'

module Dashboard
  module Plugins
    class LoadAveragesTest < Test::Unit::TestCase
      def test_load_averages
        IO.stubs(:open)
        File.stubs(:open)
        load = CPU::Load.new
        load.stubs(:num_processors).returns(4)
        load.instance_variable_set :@load_data, [ 0.23, 0.24, 0.42 ]
        CPU.expects(:load).returns(load)
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
