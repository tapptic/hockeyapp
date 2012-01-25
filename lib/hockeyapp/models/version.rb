module HockeyApp
  class Version
    extend  ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModelCompliance

    ATTRIBUTES = [:notes, :shortversion, :version, :status, :minimum_os_version, :mandatory, :timestamp, :appsize,
        :config_url, :device_family, :title]

    attr_reader *ATTRIBUTES
    attr_reader :app


    def self.from_hash(h, app, client)
      res = self.new app, client
      ATTRIBUTES.each do |attribute|
        res.send("#{attribute.to_s}=", h[attribute.to_s]) unless (h[attribute.to_s].nil?)
      end
      res
    end

    def initialize app, client
      @app = app
      @client = client
    end

    def crashes
      @crashes ||= @app.crashes.select{|crash| "#{crash.app_version_id}" == version}
    end

    def crash_reasons
      @crash_groups ||= @app.crash_reasons.select{|crash_reason| "#{crash_reason.app_version_id}" == version}
    end


    private

    attr_writer *ATTRIBUTES

  end
end