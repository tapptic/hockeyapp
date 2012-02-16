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
        0 => false,
        1 => true
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

    def crash_reasons
      @crash_groups ||= @app.crash_reasons.select{|crash_reason| "#{crash_reason.app_version_id}" == @id.to_s}
    end

    def download_url
      @download_url
    end

    private

    attr_reader :client

    def default_values!
      @dsym=nil
      @notes="New version"
      @notes_type=Version::NOTES_TYPES_TO_SYM.invert[:textile]
      @notify=Version::NOTIFY_TO_BOOL.invert[false]
      @status=Version::STATUS_TO_SYM.invert[:allow]
    end

  end
end