require 'httmultiparty'

module HockeyApp
  class WS
    include HTTMultiParty
    base_uri 'https://rink.hockeyapp.net/api/2'
    headers 'Accept' => 'application/json'
    format :json


    def initialize (options = {})
      @options = Config.to_h.merge(options)
      raise "No API Token Given" if (@options[:token].nil?)
      self.class.headers 'X-HockeyAppToken' => @options[:token]
      self.class.base_uri @options[:base_uri] if @options[:base_uri].present?
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

    def get_crash_groups_for_version app_id, version_id, options = {}
      self.class.get "/apps/#{app_id}/app_versions/#{version_id}/crash_reasons", options
    end

    def get_crashes_for_group app_id, group_id, options = {}
      self.class.get "/apps/#{app_id}/crash_reasons/#{group_id}", options
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

    def post_new_version(
        app_id,
            ipa,
            dsym=nil,
            notes="New version",
            notes_type=Version::NOTES_TYPES_TO_SYM.invert[:textile],
            notify=Version::NOTIFY_TO_BOOL.invert[:none],
            status=Version::STATUS_TO_SYM.invert[:allow],
            tags=''
    )
      params = {
          :ipa => ipa ,
          :dsym => dsym ,
          :notes => notes,
          :notes_type => notes_type,
          :notify => notify,
          :status => status,
          :tags => tags
      }
      params.reject!{|_,v|v.nil?}
      self.class.post "/apps/#{app_id}/app_versions/upload", :body => params
    end


    def remove_app app_id
      self.class.format :plain
      response = self.class.delete "/apps/#{app_id}"
      self.class.format :json
      response
    end

    def post_new_app(file_ipa,
        notes="New app",
        notes_type=App::NOTES_TYPES_TO_SYM.invert[:textile],
        notify=App::NOTIFY_TO_BOOL.invert[false],
        status=App::STATUS_TO_SYM.invert[:allow])
      params = {
          :ipa => file_ipa,
          :notes => notes,
          :notes_type => notes_type,
          :notify => notify,
          :status => status
      }
      self.class.post "/apps", :body => params
    end
  end
end
