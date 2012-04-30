module HockeyApp
  class AndroidAppUrls
    def initialize app
      @app=app
    end

    def direct_download_url
      "#{@app.last_version.download_url}?format=apk"
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
      "#{@version.download_url}?format=apk"
    end

    def install_url
      direct_download_url
    end
  end
end