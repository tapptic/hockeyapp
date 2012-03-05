require 'support/rspec_helper'

describe HockeyApp do
  before :each do
    HockeyApp::Config.configure do |config|
      config.token = "ABCDEF"
    end
  end
  it "can build a ws client" do
    client = HockeyApp.build_client
    client.should be_a HockeyApp::Client
  end
end
