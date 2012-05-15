module HockeyApp
  class AndroidAppUrls
    def initialize app
      @app=app
    end

    def direct_download_url
      "https://rink.hockeyapp.net/api/2/apps/#{@app.public_identifier}?format=apk"
    end

    def install_url
      direct_download_url
    end

  end

  class AndroidVersionUrls
    def initialize version
      @version=version
    end

    def direct_download_url
      "https://rink.hockeyapp.net/api/2/apps/#{@version.app.public_identifier}/app_versions/#{@version.id.to_s}?format=apk"
    end

    def install_url
      direct_download_url
    end
  end
end