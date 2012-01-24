module HockeyApp
  class CrashGroup
    ATTRIBUTES = [:file, :reason, :status, :id, :class, :bundle_version, :last_crash_at, :app_version_id,
        :line, :updated_at, :method, :bundle_short_version, :number_of_crashes, :fixed, :created_at, :app_id]


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