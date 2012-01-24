module HockeyApp
  class FakeWS

    def list_applications
      send "apps"
    end

    def get_crashes app_id, options = {}
      respond "crashes"
    end

    def get_crash_groups app_id, options = {}
      respond "crash_groups"
    end

    def get_versions app_id, options = {}
      respond "app_versions"
    end

    def get_crash_log app_id, options = {}
      return "log"
    end

    def get_crash_description app_id, options = {}
      return "description"
    end


    private

    def respond response_name
      eval(File.read(File.expand_path("./responses/#{response_name}.rb", File.dirname(__FILE__))))
    end


  end
end
