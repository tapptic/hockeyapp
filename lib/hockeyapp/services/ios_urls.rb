module HockeyApp
  class IOSAppUrls
    def initialize app
      @app=app
    end
    def download_url
      "https://rink.hockeyapp.net/api/2/apps/#{@app.public_identifier}?format=ipa"
    end

    def install_url
      "itms-services://?action=download-manifest&url=https://rink.hockeyapp.net/api/2/apps/#{@app.public_identifier}?format=plist"
    end
  end

  class  IOSVersionUrls

    def initialize version
      @version = version
    end

    def download_url
      "https://rink.hockeyapp.net/api/2/apps/#{@version.app.public_identifier}/app_versions/#{@version.version}?format=ipa"
    end

    def install_url
      "itms-services://?action=download-manifest&url=https://rink.hockeyapp.net/api/2/apps/#{@version.app.public_identifier}/app_versions/#{@version.version}?format=plist"
    end
  end
end