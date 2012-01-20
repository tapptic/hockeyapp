module HockeyApp
  class Crash
    ATTRIBUTES = [:crash_reason_id, :id, :jail_break, :created_at, :updated_at, :contact_string, :app_id, :bundle_version,
        :app_version_id, :user_string, :has_description, :bundle_short_version, :has_log, :model, :oem, :os_version]

    attr_reader *ATTRIBUTES
    attr_reader :application


    def self.from_hash(h, app, client)
      res = self.new app, client
      ATTRIBUTES.each do |attribute|
        res.send("#{attribute.to_s}=", h[attribute.to_s]) unless (h[attribute.to_s].nil?)
      end
      res
    end

    def initialize application, client
      @application = application
      @client = client
    end


    private

    attr_writer *ATTRIBUTES


  end
end