module HockeyApp
  class App
    extend  ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations
    include ActiveModelCompliance

    ANDROID = 'Android'
    IOS = 'iOS'

    ATTRIBUTES = [:title, :minimum_os_version, :status, :company, :owner, :bundle_identifier, :device_family, :platform,
        :public_identifier, :role, :release_type]

    POST_PAYLOAD = [:status,:notes_type, :notify]

    NOTES_TYPES_TO_SYM = {
        0 => :textile,
        1 => :markdown
    }


    NOTIFY_TO_BOOL = {
        0 => false,
        1 => true
    }

    STATUS_TO_SYM = {
        1 => :deny,
        2 => :allow
    }

    attr_accessor *ATTRIBUTES
    attr_accessor *POST_PAYLOAD


    validates :notes_type, :inclusion => { :in =>NOTES_TYPES_TO_SYM.keys }
    validates :notify, :inclusion => { :in => NOTIFY_TO_BOOL.keys }
    validates :status, :inclusion => { :in => STATUS_TO_SYM.keys }


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

    def last_version
      sorted_version = versions.sort_by { |v| v.version.to_i}
      sorted_version.last
    end

    def icon
      "https://rink.hockeyapp.net/api/2/apps/#{public_identifier}?format=png"
    end

    def download_url
      last_version.download_url
    end

    def direct_download_url
      url_strategy.direct_download_url
    end

    def install_url
      url_strategy.install_url
    end

    def create_version file, release_notes = "", notify = :none, status = :allow , tags = ""
      version = Version.new(self, @client)
      version.ipa = file
      version.notes = release_notes
      version.notify = notify
      version.status = status
      version.tags = tags
      client.post_new_version version
      @versions = nil
    end

    def remove
      client.remove_app self
    end



    private

    attr_reader :client

    def url_strategy
      return HockeyApp::IOSAppUrls.new(self) if platform == IOS
      return HockeyApp::AndroidAppUrls.new(self) if platform == ANDROID
    end

  end
end