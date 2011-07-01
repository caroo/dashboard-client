require 'yahoo_weatherman'

module Dashboard
  module Plugins
    class YahooWeather < Plugin
      option :woeid, 667931
      option :unit, 'c'


      def build_report
        if condition = Weatherman::Client.new(:unit => unit).lookup_by_woeid(woeid).full?(:condition)
          report :temp, condition['temp'], condition.subhash('text', 'code')
        else
          raise "couldn't fetch weather data for #{woeid.inspect}"
        end
      end
    end
  end
end
