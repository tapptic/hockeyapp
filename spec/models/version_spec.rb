require 'hockeyapp'
require "awesome_print"

describe HockeyApp::Version do

    before :each do
      h = {
          "notes" => "<p>Pre-rolls management</p>",
          "shortversion" => "0.9",
          "version" => "9",
          "status" => 2,
          "minimum_os_version" => nil,
          "mandatory" => false,
          "timestamp" => 1326468169,
          "appsize" => 396074,
          "config_url" => "https://rink.hockeyapp.net/manage/apps/2505/app_versions/9",
          "device_family" => nil,
          "title" => "RTL XL"
      }

      @client = HockeyApp::Client.new(HockeyApp::FakeWS.new)
      @app = HockeyApp::App.from_hash( {"public_identifier" => "91423bc5519dd2462513abbb54598959"}, @client)
      @version = HockeyApp::Version.from_hash h, @app, @client
    end

    it "can give me info about the crash" do
      @version.notes.should == "<p>Pre-rolls management</p>"
      @version.shortversion.should == "0.9"
      @version.version.should == "9"
      @version.status.should == 2
      @version.minimum_os_version.should be_nil
      @version.mandatory.should be_false
      @version.timestamp.should == 1326468169
      @version.appsize.should == 396074
      @version.config_url.should == "https://rink.hockeyapp.net/manage/apps/2505/app_versions/9"
      @version.device_family.should be_nil
      @version.title.should == "RTL XL"
      
    end

  it "calls client when asked for crashes" do
    @client.should_receive(:list_crashes).with(@app)
    @version.crashes
  end

  it "calls client when asked for crash groups" do
    @client.should_receive(:list_crash_groups).with(@app)
    @version.crash_reasons
  end


end

