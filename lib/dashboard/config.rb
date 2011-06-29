module Dashboard
  class Config
    include DSLKit::Interpreter
    extend DSLKit::ConstantMaker
    include Enumerable

    def initialize
      @plugins = []
    end

    def each(&block)
      @plugins.each(&block)
    end

    def self.interpret(source)
      new.interpret source
    end

    def interpret(source)
      interpret_with_binding source, binding
      self
    end

    def interpret_config_file(filename)
      File.open(filename) do |config|
        interpret config.read
      end
      self
    end

    def self.interpret_config_file(source)
      new.interpret_config_file source
    end

    def data_storage_directory(directory = nil)
      return @data_storage_directory if directory.nil?
      directory = directory.to_str
      if File.directory?(directory) and File.writable?(directory)
        @data_storage_directory = directory
      else
        raise "directory #{directory.inspect} is not a writable directory"
      end
    end

    def plugin(name, &block)
      plugin_class = Dashboard::Plugins.const_get(name)
      plugin = plugin_class.new
      block and plugin.configure(&block)
      @plugins << plugin
    rescue NameError => e
      raise "plugin #{name} is unknown/invalid: #{e}"
    end
  end
end
