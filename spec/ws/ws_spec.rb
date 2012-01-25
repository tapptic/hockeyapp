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
end