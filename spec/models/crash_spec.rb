require 'hockeyapp'
require "awesome_print"

describe HockeyApp::Crash do

    before :each do

      h = {
          "os_version" => "2.2.1",
          "oem" => "Samsung",
          "created_at" => "2011-12-15T20:06:49Z",
          "crash_reason_id" => 135837,
          "app_version_id" => 2,
          "app_id" => 2505,
          "has_log" => true,
          "bundle_version" => "2",
          "id" => 5511786,
          "has_description" => false,
          "bundle_short_version" => "0.2",
          "contact_string" => "",
          "jail_break" => nil,
          "updated_at" => "2011-12-15T20:06:53Z",
          "user_string" => "",
          "model" => "GT-S5830"
      }
      @client = HockeyApp::Client.new(HockeyApp::FakeWS.new)
      @app = HockeyApp::App.from_hash( {"public_identifier" => "91423bc5519dd2462513abbb54598959"}, @client)
      @crash = HockeyApp::Crash.from_hash h, @app, @client
    end

    it "can give me info about the crash" do
      @crash.os_version.should == "2.2.1"
      @crash.oem.should == "Samsung"
      @crash.created_at.should == "2011-12-15T20:06:49Z"
      @crash.crash_reason_id.should == 135837
      @crash.app_version_id.should == 2
      @crash.app_id.should == 2505
      @crash.has_log.should be_true
      @crash.bundle_version.should == "2"
      @crash.id.should == 5511786
      @crash.has_description.should be_false
      @crash.bundle_short_version.should == "0.2"
      @crash.contact_string.should == ""
      @crash.jail_break.should be_nil
      @crash.updated_at.should == "2011-12-15T20:06:53Z"
      @crash.user_string.should == ""
      @crash.model.should == "GT-S5830"
    end


  it "will call client when asked for log" do
    @client.should_receive(:detail_crash).with(@crash)
    @crash.log
  end


end

