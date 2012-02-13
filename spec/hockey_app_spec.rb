require 'support/rspec_helper'

describe HockeyApp do
  it "can build a nw client" do
    client = HockeyApp.build_client
    client.should be_a HockeyApp::Client
  end
end
