require_relative '../support/rspec_helper'

describe HockeyApp::App do

    before :each do
        h = {
            "bundle_identifier" => "com.tapptic.rtl5.rtlxl.beta",
            "device_family" => nil,
            "public_identifier" => "91423bc5519dd2462513abbb54598959",
            "company" => "tapptic",
            "release_type" => 0,
            "platform" => "Android",
            "title" => "RTL XL",
            "role" => 0,
            "status" => 2,
            "minimum_os_version" => nil,
            "owner" => "Alexandre Gherschon"
        }
      @client = HockeyApp::Client.new(HockeyApp::FakeWS.new)
      @app = HockeyApp::App.from_hash h, @client
      @model = @app
    end


    it_behaves_like "ActiveModel"

    it "can give me info about my application" do
      @app.bundle_identifier.should == "com.tapptic.rtl5.rtlxl.beta"
      @app.device_family.should be_nil
      @app.public_identifier.should == "91423bc5519dd2462513abbb54598959"
      @app.company.should == "tapptic"
      @app.release_type.should == 0
      @app.platform.should == "Android"
      @app.title.should ==  "RTL XL"
      @app.role.should == 0
      @app.status.should == 2
      @app.minimum_os_version.should be_nil
      @app.owner.should == "Alexandre Gherschon"
    end


  it "will call client when asked for crashes" do
    @client.should_receive(:get_crashes).with(@app)
    @app.crashes
  end

  it "will call client when asked for crash reasons" do
    @client.should_receive(:get_crash_groups).with(@app)
    @app.crash_reasons
  end

    it "will call client when asked for versions" do
      @client.should_receive(:get_versions).with(@app)
      @app.versions
    end

  it "can generate a download url" do
    @app.download_url.should == "https://rink.hockeyapp.net/api/2/apps/91423bc5519dd2462513abbb54598959?format=apk"
  end


end

