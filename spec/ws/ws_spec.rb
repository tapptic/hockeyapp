require 'hockeyapp'
require "awesome_print"

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


  context "when there is a valid API token" do

    before :each do
      HockeyApp::Config.configure do |config|
        config.token = "07eeac9bf4a1416891b2930f626fc5cb"
      end
      @client = HockeyApp::Client.new(HockeyApp::WS.new)
    end


  end
end