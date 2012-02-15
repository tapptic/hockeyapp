require 'active_support/core_ext/object/blank'
require 'active_model'
require 'hockeyapp/models/active_model_compliance'
require "hockeyapp/models/app"
require 'hockeyapp/models/crash'
require 'hockeyapp/models/version'
require 'hockeyapp/models/crash_group'
require 'hockeyapp/ws/ws'
require 'hockeyapp/ws/client'
require 'hockeyapp/config'
require 'hockeyapp/services/android_urls'
require 'hockeyapp/services/ios_urls'

module HockeyApp
  extend self

  def build_client options = {}
    ws = WS.new options
    Client.new ws
  end
end




