module HockeyApp
  class IOSAppUrls
    def initialize app
      @app=app
    end
    def download_url
      "https://rink.hockeyapp.net/apps/#{@app.public_identifier}"
    end

    def direct_download_url
      @app.last_version.direct_download_url
    end

    def install_url
      @app.last_version.install_url
    end

  end

  class  IOSVersionUrls

    def initialize version
      @version = version
    end

    def direct_download_url
      "https://rink.hockeyapp.net/api/2/apps/#{@version.app.public_identifier}/app_versions/#{@version.id.to_s}?format=ipa"
    end

    def install_url
      location = "https://rink.hockeyapp.net/api/2/apps/#{@version.app.public_identifier}/app_versions/#{@version.id.to_s}?format=plist"
      "itms-services://?action=download-manifest&url=#{CGI::escape(location)}"
    end
  end
end