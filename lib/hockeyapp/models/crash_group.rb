module HockeyApp
  class CrashGroup
    extend  ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations
    include ActiveModelCompliance

    ATTRIBUTES = [:file, :reason, :status, :id, :crash_class, :bundle_version, :last_crash_at, :app_version_id,
        :line, :updated_at, :method, :bundle_short_version, :number_of_crashes, :fixed, :created_at, :app_id]


    attr_accessor *ATTRIBUTES
    attr_reader :app


    def self.from_hash(h, app, client)
      res = self.new app, client
      ATTRIBUTES.each do |attribute|
        res.send("#{attribute.to_s}=", h[attribute.to_s]) unless (h[attribute.to_s].nil?)
      end
      res.send("crash_class=", h['class']) unless h['class'].nil? # we should not override the #class method
      res
    end

    def initialize app, client
      @app = app
      @client = client
    end

    def crashes options = {}
      @crashes ||= client.get_crashes_for_crash_group(self, options)
    end

    private

    attr_reader :client

  end
end