require_relative '../support/rspec_helper'

describe HockeyApp::CrashGroup do

    before :each do
      h = {
          "file" => "AbstractParser.java",
          "reason" => "java.lang.RuntimeException: An error occured while executing doInBackground()",
          "status" => 1,
          "id" => 135837,
          "class" => "com.tapptic.common.parser.AbstractParser",
          "bundle_version" => "2",
          "last_crash_at" => "2011-12-15T20:07:11Z",
          "app_version_id" => 2,
          "line" => "48",
          "updated_at" => "2012-01-03T13:22:01Z",
          "bundle_short_version" => "0.2",
          "method" => "parse",
          "number_of_crashes" => 2,
          "fixed" => true,
          "created_at" => "2011-12-15T20:06:49Z",
          "app_id" => 9999
      }
      @client = HockeyApp::Client.new(HockeyApp::FakeWS.new)
      @app = HockeyApp::App.from_hash( {"public_identifier" => "91423bc5519dd2462513abbb54598959"}, @client)
      @crash_group = HockeyApp::CrashGroup.from_hash h, @app, @client
      @model = @crash_group
      @options = {}
    end

    it_behaves_like "ActiveModel"

    it "can give me info about the crash group" do
      @crash_group.file.should == "AbstractParser.java"
      @crash_group.reason.should == "java.lang.RuntimeException: An error occured while executing doInBackground()"
      @crash_group.status.should == 1
      @crash_group.id.should == 135837
      @crash_group.crash_class.should == "com.tapptic.common.parser.AbstractParser"
      @crash_group.bundle_version.should == "2"
      @crash_group.last_crash_at.should == "2011-12-15T20:07:11Z"
      @crash_group.app_version_id.should == 2
      @crash_group.updated_at.should == "2012-01-03T13:22:01Z"
      @crash_group.bundle_short_version.should == "0.2"
      @crash_group.method.should == "parse"
      @crash_group.number_of_crashes.should == 2
      @crash_group.fixed.should == true
      @crash_group.created_at.should == "2011-12-15T20:06:49Z"
      @crash_group.app_id.should == 9999
    end

    it "calls client once when asked for crashes" do
      @client.should_receive(:get_crashes_for_crash_group).with(@crash_group, @options).and_return([])
      @crash_group.crashes
      @client.should_not_receive(:get_crashes_for_crash_group).with(@crash_group, @options)
      @crash_group.crashes
    end

end

