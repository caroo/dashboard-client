require 'fileutils'

module Dashboard
  class Plugin
    include FileUtils

    extend DSLKit::DSLAccessor

    class << self
      alias option dsl_accessor
    end

    option :every, 1 # every second

    option :name do
      self.class.name[/::([^:]+)\Z/, 1]
    end

    option :persistent, true

    def initialize(options = {})
      @options = options.symbolize_keys_recursive
      @memory = {}
      @report = Report.new
    end

    attr_accessor :client

    attr_accessor :last_run

    attr_reader :memory

    def debugging
      client.full?(:debugging)
    end

    def configure(&block)
      instance_eval(&block)
    end

    def counter(name, value, options = {})
      optiones |= { :per => :second }
    end

    def memory(values)

    end

    def remember(*rest)
    end

    def report(name, value, options = {})
      @report.add(name, value, options)
      self
    end

    def error(exception)
      @report.error exception
      self
    end

    def path(*parts)
      @client.full? do |c|
        File.join(c.config.data_storage_directory, self.class.name[/::([^:]+)\Z/, 1], *parts)
      end
    end

    # Old plugins will work because they override this method.  New plugins can
    # now leave this method in place, add a build_report() method instead, and
    # use the new helper methods to build up content inside which will
    # automatically be returned as the end result of the run.
    # 
    def run
      @report = Report.new
      @report.plugin = self
      build_report
    rescue Exception => e
      @report.error e
    ensure
      return @report
    end
  end
end
