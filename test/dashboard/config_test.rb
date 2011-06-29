require 'test/unit'
require 'fileutils'
require 'dashboard'

module Dashboard
  class ConfigTest < Test::Unit::TestCase
    include Dashboard
    include FileUtils

    SIMPLE_CONFIG =<<-EOT
    data_storage_directory '/tmp/dashboard.#$$'

    plugin LoadAverages

    plugin DiskUsage

    plugin CodeCoverage do
      every 3.hours
    end
    EOT

    def setup
      mkdir_p "/tmp/dashboard.#$$"
    end

    def teardown
      rm_rf "/tmp/dashboard*.#$$"
    end

    def test_simple_config(dc = Dashboard::Config.new)
      assert_kind_of Dashboard::Config, dc
      dc.interpret SIMPLE_CONFIG
      assert dc.any? { |p| Plugins::LoadAverages === p }
      assert dc.any? { |p| Plugins::DiskUsage === p }
      assert dc.any? { |p| Plugins::CodeCoverage === p }
      cc = dc.grep(Plugins::CodeCoverage).first
      assert_equal 3.hours, cc.every
      la = dc.grep(Plugins::LoadAverages).first
    end

    def test_simple_config_file
      config_file_name = "/tmp/dashbordrc.#$$"
      File.open(config_file_name, 'w') do |rc| rc.write SIMPLE_CONFIG end
      dc = Dashboard::Config.new.interpret_config_file config_file_name
      test_simple_config dc
    end
  end
end
