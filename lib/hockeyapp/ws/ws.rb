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
    
    
    def list_applications
      self.class.get '/apps'
    end


    def list_crashes app_id, options = {}
      self.class.get "/apps/#{app_id}/crashes", options
    end

    def list_crash_groups app_id, options = {}
      self.class.get "/apps/#{app_id}/crash_reasons", options
    end

    #def detail_crash app_id, crash_id, options = {}
    #  self.class.format :plain
    #  self.class.get "/apps/#{app_id}/crashes/#{crash_id}?format=log", options
    #end

    def list_versions app_id, options = {}
      self.class.get "/apps/#{app_id}/app_versions", options
    end


  end
end