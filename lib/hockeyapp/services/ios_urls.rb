module HockeyApp
  class IOSAppUrls
    def initialize app
      @app=app
    end
    def download_url
      @app.last_version.download_url
    end

    def direct_download_url
      "#{@app.last_version.download_url}?format=ipa"
    end

    def install_url
      location = "#{@app.last_version.download_url}?format=plist"
      "itms-services://?action=download-manifest&url=#{CGI::escape(location)}"
    end
  end

  class  IOSVersionUrls

    def initialize version
      @version = version
    end

    def direct_download_url
      "#{@version.download_url}?format=ipa"
    end

    def install_url
      location = "#{@version.download_url}?format=plist"
      "itms-services://?action=download-manifest&url=#{CGI::escape(location)}"
    end
  end
end