module HockeyApp
  class Version
    extend  ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations
    include ActiveModelCompliance

    ATTRIBUTES = [:id, :notes, :shortversion, :version, :mandatory, :timestamp, :appsize,  :title, :download_url]

    POST_PAYLOAD = [:status, :ipa, :dsym, :notes_type, :notify, :tags]

    NOTES_TYPES_TO_SYM = {
        0 => :textile,
        1 => :markdown
    }


    NOTIFY_TO_BOOL = {
        0 => :none,
        1 => :all_allowed,
	2 => :all
    }

    STATUS_TO_SYM = {
        1 => :deny,
        2 => :allow
    }

    attr_accessor *ATTRIBUTES
    attr_accessor *POST_PAYLOAD
    attr_reader :app

    validates :notes_type, :inclusion => { :in =>NOTES_TYPES_TO_SYM.keys }
    validates :notify, :inclusion => { :in => NOTIFY_TO_BOOL.keys }
    validates :status, :inclusion => { :in => STATUS_TO_SYM.keys }


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
      default_values!
    end


    def to_key
      [@id] if persisted?
    end

    def crashes
      @crashes ||= @app.crashes.select{|crash| "#{crash.app_version_id}" == @id.to_s}
    end

    def crash_reasons options = {}
      @crash_groups ||= client.get_crash_groups_for_version(self, options)
    end


    def direct_download_url
      url_strategy.direct_download_url
    end

    def install_url
      url_strategy.install_url
    end

    private

    attr_reader :client

    def default_values!
      @dsym=nil
      @notes="New version"
      @notes_type=Version::NOTES_TYPES_TO_SYM.invert[:textile]
      @notify=Version::NOTIFY_TO_BOOL.invert[:none]
      @status=Version::STATUS_TO_SYM.invert[:allow]
    end

    def url_strategy
      return HockeyApp::IOSVersionUrls.new(self) if app.platform == HockeyApp::App::IOS
      return HockeyApp::AndroidVersionUrls.new(self) if app.platform == HockeyApp::App::ANDROID
    end

  end
end