require_relative '../../spec/support/rspec_helper'


describe HockeyApp::WS do
  context "when there is no token given" do

    before :each do
      HockeyApp::Config.configure do |config|
        config.token = nil
      end
    end

    it "should raise an exception when creating a new client" do
      lambda {HockeyApp::WS.new()}.should raise_error
    end
  end

  context "when base_uri is defined" do
    before :each do
      HockeyApp::Config.configure do |config|
        config.token = "ABCDEF"
        config.base_uri = "http://example.com/api"
      end
    end


      it "should use the config uri as endpoint" do
        subject.class.base_uri.should == "http://example.com/api"
      end

  end
end