require 'nokogiri'
require 'open-uri'

module Dashboard
  module Plugins
    class Hudson < Plugin
      option :uri

      MAP = [
        /\A\?\Z/,           :building,
        /broken/,           :broken,
        /(stable|normal)/,  :stable,
        /aborted/,          :aborted,
      ]

      def build_report
        uri or raise MissingPluginOption, "require uri option in order to function"
        doc = open("#{uri}/rssLatest") { |data| Nokogiri::XML(data) }
        doc.remove_namespaces!
        titles = (doc / '//feed/entry/title').map(&:text)
        for title in titles
          if title =~ /\A(.*)?\s+#\d+\s+\((.*?)\)/
            name, value = $1, $2
            report name, MAP.each_cons(2).find { |regexp, v| regexp =~ value and break v } || :unknown
          end
        end
      end
    end
  end
end
