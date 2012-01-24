module HockeyApp
  class App
    extend  ActiveModel::Naming
    include ActiveModel::Conversion

    ATTRIBUTES = [:title, :minimum_os_version, :status, :company, :owner, :bundle_identifier, :device_family, :platform,
        :public_identifier, :role, :release_type]

    attr_reader *ATTRIBUTES


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

    def to_model
      self
    end
    def persisted?
      false
    end
    def valid?()      true end
    def new_record?() true end
    def destroyed?()  true end

    def errors
      obj = Object.new
      def obj.[](key)         [] end
      def obj.full_messages() [] end
      obj
    end

    def crashes
      @crashes = @client.get_crashes(self) if @crashes.nil?
    end

    def crash_reasons
      @crash_reasons ||= @client.get_crash_groups(self)
    end

    def download_url
      "https://rink.hockeyapp.net/api/2/apps/#{public_identifier}?format=#{download_format}"
    end

    private

    attr_writer *ATTRIBUTES

    def download_format
      case platform
        when "Android" then "apk"
        else ""
      end
    end
  end
end