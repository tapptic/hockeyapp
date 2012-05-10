require_relative '../support/rspec_helper'

describe HockeyApp::App do

  before :each do
    h = {
        "bundle_identifier" => "de.codenauts.hockeytest.beta",
        "device_family" => "iPhone/iPod",
        "public_identifier" =>  "1234567890abcdef1234567890abcdef",
        "company" => "some company",
        "release_type" => 0,
        "platform" => "iOS",
        "title" => "Hockey Test",
        "role" => 0,
        "status" => 2,
        "minimum_os_version" => "4.0",
        "owner" => "John Doe"
    }
    @client = HockeyApp::Client.new(HockeyApp::FakeWS.new)
    @app = HockeyApp::App.from_hash h, @client
    @model = @app
  end

  it_behaves_like "ActiveModel"

  it "can give me info about my application" do
    @app.bundle_identifier.should == "de.codenauts.hockeytest.beta"
    @app.device_family.should == "iPhone/iPod"
    @app.public_identifier.should ==  "1234567890abcdef1234567890abcdef"
    @app.company.should == "some company"
    @app.release_type.should == 0
    @app.platform.should == "iOS"
    @app.title.should ==  "Hockey Test"
    @app.role.should == 0
    @app.status.should == 2
    @app.minimum_os_version.should == "4.0"
    @app.owner.should == "John Doe"
  end


  it "will call client once when asked for crashes" do
    @client.should_receive(:get_crashes).with(@app).and_return([])
    @app.crashes
    @client.should_not_receive(:get_crashes).with(@app)
    @app.crashes
  end

  it "will call client once when asked for crash reasons" do
    @client.should_receive(:get_crash_groups).with(@app).and_return([])
    @app.crash_reasons
    @client.should_not_receive(:get_crash_groups).with(@app)
    @app.crash_reasons
  end

  it "will call client once when asked for versions" do
    @client.should_receive(:get_versions).with(@app).and_return([])
    @app.versions
    @client.should_not_receive(:get_versions).with(@app)
    @app.versions
  end

  it "can generate a download url" do
    @app.download_url.should == "https://rink.hockeyapp.net/apps/0873e2b98ad046a92c170a243a8515f6/app_versions/208"
  end



  it "can generate a direct download url for Android" do
    @app.platform = "Android"
    @app.direct_download_url.should == "https://rink.hockeyapp.net/api/2/apps/1234567890abcdef1234567890abcdef?format=apk"
  end

  it "can generate a direct download url for iOS" do
    @app.platform = "iOS"
    @app.direct_download_url.should == "https://rink.hockeyapp.net/api/2/apps/1234567890abcdef1234567890abcdef/app_versions/208?format=ipa"
  end

  it "can generate an install url for iOS" do
    @app.install_url.should == "itms-services://?action=download-manifest&url=https%3A%2F%2Frink.hockeyapp.net%2Fapi%2F2%2Fapps%2F1234567890abcdef1234567890abcdef%2Fapp_versions%2F208%3Fformat%3Dplist"
  end

  it "can generate an icon url for iOS" do
    @app.icon.should == "https://rink.hockeyapp.net/api/2/apps/1234567890abcdef1234567890abcdef?format=png"
  end

  it "can generate an icon url for Android" do
    @app.platform = "Android"
    @app.icon.should == "https://rink.hockeyapp.net/api/2/apps/1234567890abcdef1234567890abcdef?format=png"
  end

  it "can generate an install url for Android" do
    @app.platform = "Android"
    @app.install_url.should == @app.direct_download_url
  end


  describe "#create_version" do
    it "will create a new version instance and pass it to the webservice" do
      release_notes = "New version from automated test"
      binary_file = double('file')
      fake_version = double('version')
      HockeyApp::Version.should_receive(:new).with(@app, @client).and_return(fake_version)
      fake_version.should_receive(:ipa=).with(binary_file)
      fake_version.should_receive(:notes=).with(release_notes)
      @client.should_receive(:post_new_version).with(fake_version)
      @app.create_version(binary_file, release_notes)
    end

  end

  describe "#remove_app", :js => true do
    it "will remove an app from hockeyapp", :driver => :webkit do
      @client.should_receive(:remove_app).with(@app).and_return(true)
      @app.remove
    end
  end

  describe "#last_version" do

    it "sorts the versions" do
      versions = double("versions")
      @app.should_receive(:versions).and_return(versions)
      versions.should_receive(:sort_by).and_return([])
      @app.last_version
    end

    context "there are 3 versions for this app" do
      before :each do
        @version1 = double("Version1", :version => "5")
        @version2 = double("Version2", :version => "10")
        @version3 = double("Version3", :version => "6")
        @versions = [@version1, @version2, @version3]

      end
      it "returns the last version" do
        @app.should_receive(:versions).and_return(@versions)
        @app.last_version.version.should == "10"
      end
    end


  end
end