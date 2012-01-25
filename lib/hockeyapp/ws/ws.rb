require 'httparty'

module HockeyApp
  class WS
    include HTTParty
    base_uri 'https://rink.hockeyapp.net/api/2'
    headers 'Accept' => 'application/json'
    format :json
    

    def initialize (options = {})
      @options = Config.to_h.merge(options)
      raise "No API Token Given" if (@options[:token].nil?)
      self.class.headers 'X-HockeyAppToken' => @options[:token]
    end
    
    
    def get_apps
      self.class.get '/apps'
    end


    def get_crashes app_id, options = {}
      self.class.get "/apps/#{app_id}/crashes", options
    end

    def get_crash_groups app_id, options = {}
      self.class.get "/apps/#{app_id}/crash_reasons", options
    end

    # this is damn not thread safe !
    def get_crash_log app_id, crash_id, options = {}
      self.class.format :plain
      log = self.class.get "/apps/#{app_id}/crashes/#{crash_id}?format=log", options
      self.class.format :json
      log
    end

    # this is damn not thread safe !
    def get_crash_description app_id, crash_id, options = {}
      self.class.format :plain
      description = self.class.get "/apps/#{app_id}/crashes/#{crash_id}?format=text", options
      self.class.format :json
      description
    end

    def get_versions app_id, options = {}
      self.class.get "/apps/#{app_id}/app_versions", options
    end


  end
end