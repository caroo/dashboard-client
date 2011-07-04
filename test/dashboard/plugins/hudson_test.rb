require 'mocha'
require 'test/unit'
require 'dashboard'

module Dashboard
  module Plugins
    class HudsonTest < Test::Unit::TestCase
      RESPONSE_XML = <<EOT
<?xml version="1.0" encoding="UTF-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
  <title>All last builds only</title>
  <link type="text/html"
  href="http://uranus.mediaventures.intern:3000/"
  rel="alternate" />
  <updated>2011-07-01T12:00:08Z</updated>
  <author>
    <name>Hudson Server</name>
  </author>
  <id>urn:uuid:903deee0-7bfa-11db-9fe1-0800200c9a66</id>
  <entry>
    <title>billing_service #88 (broken since this build)</title>
    <link type="text/html"
    href="http://uranus.mediaventures.intern:3000/job/billing_service/88/"
    rel="alternate" />
    <id>
    tag:hudson.dev.java.net,2008:http://uranus.mediaventures.intern:3000/job/billing_service/</id>
    <published>2011-07-01T12:00:08Z</published>
    <updated>2011-07-01T12:00:08Z</updated>
  </entry>
  <entry>
    <title>mos_eisley #49 (stable)</title>
    <link type="text/html"
    href="http://uranus.mediaventures.intern:3000/job/mos_eisley/49/"
    rel="alternate" />
    <id>
    tag:hudson.dev.java.net,2008:http://uranus.mediaventures.intern:3000/job/mos_eisley/</id>
    <published>2011-06-09T09:47:33Z</published>
    <updated>2011-06-09T09:47:33Z</updated>
  </entry>
  <entry>
    <title>pkwde #586 (aborted)</title>
    <link type="text/html"
    href="http://uranus.mediaventures.intern:3000/job/pkwde/586/"
    rel="alternate" />
    <id>
    tag:hudson.dev.java.net,2008:http://uranus.mediaventures.intern:3000/job/pkwde/</id>
    <published>2011-07-01T11:53:44Z</published>
    <updated>2011-07-01T11:53:44Z</updated>
  </entry>
  <entry>
    <title>pkwde-rcov #229 (?)</title>
    <link type="text/html"
    href="http://uranus.mediaventures.intern:3000/job/pkwde-rcov/229/"
    rel="alternate" />
    <id>
    tag:hudson.dev.java.net,2008:http://uranus.mediaventures.intern:3000/job/pkwde-rcov/</id>
    <published>2011-07-01T09:32:01Z</published>
    <updated>2011-07-01T09:32:01Z</updated>
  </entry>
</feed>
EOT

      def test_hudson_plugin
        plugin = Hudson.new
        plugin.uri 'something'
        plugin.expects(:open).returns(Nokogiri::XML(RESPONSE_XML))
        report, = plugin.run
        assert_nil report.exception
        assert_equal [
          { :options=>{}, :value=>:broken, :name=>"billing_service" },
          { :options=>{}, :value=>:stable, :name=>"mos_eisley" },
          { :options=>{}, :value=>:aborted, :name=>"pkwde" },
          { :options=>{}, :value=>:building, :name=>"pkwde-rcov" }
        ], report.values
      end
    end
  end
end

