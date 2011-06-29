module Dashboard
  class Report
    def initialize
      @timestamp = Time.now
      @values = []
    end

    attr_reader :values

    attr_reader :exception

    attr_accessor :plugin

    def name
      plugin.name
    end

    def error(exception)
      @exception = exception
    end

    def add(name, value, options = {})
      @values << { :name => name, :value => value, :options => options }
    end

    def filename
      @plugin.full? { |p| p.path('values', "value-#{@timestamp.strftime('%Y%m%d%H%M%S')}.json") }
    end

    def self.json_create(data)
      data = data.symbolize_keys_recursive
      obj = new
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
        :values        => @values
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
