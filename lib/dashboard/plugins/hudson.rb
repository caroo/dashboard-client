require 'nokogiri'
require 'open-uri'

module Dashboard
  module Plugins
    class Hudson < Plugin
      option :uri

      BUILD_STATES = [
        /\A\?\Z/,           :building,
        /broken/,           :broken,
        /(stable|normal)/,  :stable,
        /aborted/,          :aborted,
      ]

      def fetch_document(uri)
        open(uri) { |data| Nokogiri::XML(data) }
      end

      def build_report
        uri or raise MissingPluginOption, "require uri option in order to function"
        doc = fetch_document("#{uri}/rssLatest")
        doc.remove_namespaces!
        titles = (doc / '//feed/entry/title').map(&:text)
        for title in titles
          if title =~ /\A(.*)?\s+#(\d+)\s+\((.*?)\)/
            name, value, state = $1, $2.to_i, $3
            report name, value,
              :build_state => BUILD_STATES.each_cons(2).find { |regexp, s| regexp =~ state and break s } || :unknown
          end
        end
      end
    end
  end
end
