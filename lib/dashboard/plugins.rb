module Dashboard
  module Plugins
    dir = File.join(File.dirname(__FILE__), 'plugins')
    for plugin in Dir[File.join(dir, '*.rb')]
      plugin = File.basename(plugin)
      plugin.sub!(/\.rb/, '')
      require "dashboard/plugins/#{plugin}"
    end
  end
end
