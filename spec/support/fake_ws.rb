module HockeyApp
  class FakeWS

    def get_apps
      respond "apps"
    end

    def get_crashes app_id, options = {}
      respond "crashes"
    end

    def get_crash_groups app_id, options = {}
      respond "crash_groups"
    end

    def get_versions app_id, options = {}
      respond "app"
    end


    def get_crash_description app_id, options = {}
      return "crash_description"
    end

    def get_crash_log app_id, options = {}
      return "crash_log"
    end

    def post_new_version app_id, ipa, dsym=nil, notes=nil, notes_type=nil, notify=nil, status=nil
      respond "new_version"
    end




    private

    def respond response_name
      eval(File.read(File.expand_path("./responses/#{response_name}.rb", File.dirname(__FILE__))))
    end


  end
end
