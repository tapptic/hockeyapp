module HockeyApp
  class Crash
    extend  ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations
    include ActiveModelCompliance

    ATTRIBUTES = [:crash_reason_id, :id, :jail_break, :created_at, :updated_at, :contact_string, :app_id, :bundle_version,
        :app_version_id, :user_string, :has_description, :bundle_short_version, :has_log, :model, :oem, :os_version]

    attr_accessor *ATTRIBUTES
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


    def log
      @log ||= client.get_crash_log(self) if has_log
    end

    def description
      @description ||= client.get_crash_description(self) if has_description
    end


    private

    attr_accessor :client


  end
end