module HockeyApp
  class IOSAppUrls
    def initialize app
      @app=app
    end
    def download_url
      "https://rink.hockeyapp.net/api/2/apps/#{@app.public_identifier}?format=ipa"
    end

    def install_url
      location = "https://rink.hockeyapp.net/api/2/apps/#{@app.public_identifier}?format=plist"
      "itms-services://?action=download-manifest&url=#{CGI::escape(location)}"
    end
  end

  class  IOSVersionUrls

    def initialize version
      @version = version
    end

    def install_url
      location = "https://rink.hockeyapp.net/api/2/apps/#{@version.app.public_identifier}/app_versions/#{@version.id.to_s}?format=plist"
      "itms-services://?action=download-manifest&url=#{CGI::escape(location)}"
    end
  end
end