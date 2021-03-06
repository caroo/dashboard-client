module Dashboard
  class Report
    def initialize
      @timestamp = DateTime.now
      @values = []
    end

    attr_reader :values

    attr_reader :exception

    attr_accessor :plugin

    attr_reader :timestamp

    def name
      @name ||= plugin.full?(:name)
    end

    def error(exception)
      @exception = exception
    end

    def add(name, value, options = {})
      @values << { :name => name, :value => value, :options => options }
    end

    def value_hash(name)
      @values.find { |v| v[:name] == name }
    end

    def value(name)
      value_hash(name).full?(:[], :value)
    end

    def filename
      @plugin.full? { |p| p.path('values', "#{(name || 'value').gsub(/\W+/, '_').downcase}-#{@timestamp.strftime('%Y%m%d%H%M%S')}.json") }
    end

    def success?
      exception.nil?
    end

    def failure?
      not success?
    end

    def self.json_create(data)
      data = data.symbolize_keys_recursive
      obj = new
      obj.instance_eval do
        name = data[:name] and @name = name
        timestamp = data[:timestamp] and @timestamp = timestamp
      end
      for value in data[:values]
        name, value, options = value.values_at :name, :value, :options
        obj.add name, value, options
      end
      exception = data[:exception] and obj.error exception
      obj
    end

    def as_json(*)
      result = {
        JSON.create_id => self.class.name,
        :name          => name,
        :values        => @values,
        :timestamp     => @timestamp.as_json
      }
      @exception and
        result |= {
          :exception => @exception.as_json,
        }
      result
    end

    def to_json(*args)
      as_json.to_json(*args)
    end
  end
end
