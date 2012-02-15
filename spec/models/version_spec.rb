require_relative '../../spec/support/rspec_helper'


describe HockeyApp::Version do

    before :each do
      @h = {
          "notes" => "<p>Pre-rolls management</p>",
          "shortversion" => "0.9",
          "version" => "9",

          "timestamp" => 1326468169,
          "appsize" => 396074,
          "title" => "Test App"
      }

      @client = HockeyApp::Client.new(HockeyApp::FakeWS.new)
      @app = HockeyApp::App.from_hash( {"public_identifier" => "91423bc5519dd2462513abbb54598959"}, @client)
      @version = HockeyApp::Version.from_hash @h, @app, @client
      @model = @version
    end

    subject{@version}

    it_behaves_like "ActiveModel"

    it "can give me info about the version" do
      @version.notes.should == "<p>Pre-rolls management</p>"
      @version.shortversion.should == "0.9"
      @version.version.should == "9"


      @version.mandatory.should be_false
      @version.timestamp.should == 1326468169
      @version.appsize.should == 396074
      @version.title.should == "Test App"
      
    end

  it "calls client once  when asked for crashes" do
    @client.should_receive(:get_crashes).with(@app).and_return([])
    @version.crashes
    @client.should_not_receive(:get_crashes).with(@app)
    @version.crashes
  end

  it "calls client once when asked for crash groups" do
    @client.should_receive(:get_crash_groups).with(@app).and_return([])
    @version.crash_reasons
    @client.should_not_receive(:get_crash_groups).with(@app)
    @version.crash_reasons
  end

  it "can generate a download url for iOS" do
    @app.platform= "iOS"
    @version = HockeyApp::Version.from_hash @h, @app, @client
    @version.download_url.should == "https://rink.hockeyapp.net/api/2/apps/91423bc5519dd2462513abbb54598959/app_versions/9?format=ipa"
  end

  it "can generate a download url for Android" do
    @app.platform = "Android"
    @version = HockeyApp::Version.from_hash @h, @app, @client
    @version.download_url.should == "https://rink.hockeyapp.net/api/2/apps/91423bc5519dd2462513abbb54598959/app_versions/9?format=apk"
  end

  it "can generate an install url for iOS" do
    @app.platform= "iOS"
    @version = HockeyApp::Version.from_hash @h, @app, @client
    @version.install_url.should == "itms-services://?action=download-manifest&url=https://rink.hockeyapp.net/api/2/apps/91423bc5519dd2462513abbb54598959/app_versions/9?format=plist"
  end

  it "can generate an install url for Android" do
    @app.platform = "Android"
    @version = HockeyApp::Version.from_hash @h, @app, @client
    @version.install_url.should == "https://rink.hockeyapp.net/api/2/apps/91423bc5519dd2462513abbb54598959/app_versions/9?format=apk"
  end


end

