require 'spruz/xt'
require 'json/add/core'
require 'dslkit/polite'

module Dashboard

  class DashboardError < StandardError; end
  class PluginError < DashboardError; end
  class MissingPluginOption < PluginError; end
  class DataFeedUnavailable < PluginError; end

  require 'dashboard/version'
  require 'dashboard/xt/numeric'
  require 'dashboard/plugin'
  require 'dashboard/config'
  require 'dashboard/report'
  require 'dashboard/plugins'
  require 'dashboard/client'
end
