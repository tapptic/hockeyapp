require_relative '../../spec/support/rspec_helper'


describe HockeyApp::Client do
  context "when there are valid responses" do

    let(:client) {HockeyApp::Client.new(HockeyApp::FakeWS.new)}
    let(:app) {HockeyApp::App.from_hash({"public_identifier" => "91423bc5519dd2462513abbb54598959"}, client)}

    describe "#get_apps" do
      it "returns an Enumerable " do
        client.get_apps.should be_kind_of Enumerable
      end

      it "has a single element " do
        client.get_apps.should have(1).item
      end

      it "returns App objectys" do
        client.get_apps[0].should be_kind_of HockeyApp::App
      end

    end

    describe "#get_crashes" do
      it "returns an Enumerable " do
        client.get_crashes(app).should be_kind_of Enumerable
      end

      it "has a 10 elements " do
        client.get_crashes(app).should have(10).items
      end

      it "returns Crash objects" do
        client.get_crashes(app)[0].should be_kind_of HockeyApp::Crash
      end

    end

    describe "#get_crash_groups" do
      it "returns an Enumerable " do
        client.get_crash_groups(app).should be_kind_of Enumerable
      end

      it "has a 7 elements " do
        client.get_crash_groups(app).should have(7).items
      end

      it "returns CrashGroup objects" do
        client.get_crash_groups(app)[0].should be_kind_of HockeyApp::CrashGroup
      end

    end

    describe "#get_versions" do
      it "returns an Enumerable " do
        client.get_versions(app).should be_kind_of Enumerable
      end

      it "has a 9 elements " do
        client.get_versions(app).should have(9).items

      end

      it "returns Version objects" do
        client.get_versions(app)[0].should be_kind_of HockeyApp::Version
      end

    end


  end
end