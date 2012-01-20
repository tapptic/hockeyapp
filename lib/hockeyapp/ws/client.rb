module HockeyApp
  class Client

    def initialize ws
      @ws = ws
    end

    def list_apps
      apps_hash = ws.list_applications
      assert_success apps_hash
      apps_hash["apps"].map{|app_hash|App.from_hash(app_hash, self)}
    end

    def list_crashes app
      crashes_hash = ws.list_crashes app.public_identifier
      assert_success crashes_hash
      crashes_hash["crashes"].map{|crash_hash|Crash.from_hash(crash_hash, app, self)}
    end

    def list_crash_groups app
      crash_groups_hash = ws.list_crash_groups app.public_identifier
      assert_success crash_groups_hash
      crash_groups_hash["crash_reasons"].map{|reason_hash|CrashGroup.from_hash(reason_hash, app, self)}
    end


    private

    def assert_success hash
      status = hash["status"]
      raise "Bad Status : #{status}" unless status == "success"
    end

  end
end