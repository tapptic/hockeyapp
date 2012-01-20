module HockeyApp
  class FakeWS
    def list_applications
      respond "apps"
    end

    def list_crashes app_id, options = {}
      respond "crashes"
    end

    def list_crash_groups app_id, options = {}
      respond "crash_groups"
    end

    def list_versions app_id, options = {}
      respond "app_versions"
    end
  end

  private

  def respond response_name
    eval(File.read(File.expand_path("./responses/#{response_name}.rb", __FILE__)))
  end
end
