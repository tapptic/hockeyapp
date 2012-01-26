module HockeyApp
  class App
    extend  ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations
    include ActiveModelCompliance

    ATTRIBUTES = [:title, :minimum_os_version, :status, :company, :owner, :bundle_identifier, :device_family, :platform,
        :public_identifier, :role, :release_type]

    attr_accessor *ATTRIBUTES


    def self.from_hash(h, client)
      res = self.new client
      ATTRIBUTES.each do |attribute|
        res.send("#{attribute.to_s}=", h[attribute.to_s]) unless (h[attribute.to_s].nil?)
      end
      res
    end

    def initialize client
      @client = client
    end

    def to_key
      [public_identifier] if persisted?
    end



    def crashes
      @crashes ||= client.get_crashes(self)
    end

    def crash_reasons
      @crash_reasons ||= client.get_crash_groups(self)
    end

    def versions
      @versions ||= client.get_versions(self)
    end

    def download_url
      "https://rink.hockeyapp.net/api/2/apps/#{public_identifier}?format=#{download_format}"
    end

    private

    attr_reader :client

    def download_format
      case platform
        when "Android" then "apk"
        when "iOS" then "ipa"
        else ""
      end
    end
  end
end