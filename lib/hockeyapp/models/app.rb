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

    def platform= platform
      @platform = platform
      @url_strategy = HockeyApp::IOSAppUrls.new(self) if platform == "iOS"
      @url_strategy = HockeyApp::AndroidAppUrls.new(self) if platform == "Android"
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
      @url_strategy.download_url
    end

    def install_url
      @url_strategy.install_url
    end

    def create_version file, release_notes = ""
      version = Version.new(self, @client)
      version.ipa = file
      version.notes = release_notes
      client.post_new_version version
      @versions = nil
    end


    private

    attr_reader :client

    def download_format
      case platform
        when "Android" then "apk"
        when "iOS" then "ipa"
      end
    end
  end
end