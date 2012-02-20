require_relative 'support/rspec_helper'

describe HockeyApp::Config do
  
  it "can be set throug configure method" do
    HockeyApp::Config.configure do |config|
      config.token = "ABCDEF"
    end

    HockeyApp::Config.token.should == "ABCDEF"
  end

  it "can store a token" do
    HockeyApp::Config.token = "ABCDEF"
    HockeyApp::Config.token.should == "ABCDEF"
  end

  it "can store a base_uri" do
    HockeyApp::Config.base_uri = "foo"
    HockeyApp::Config.base_uri.should == "foo"
  end

  it "can transform into a hash" do
    HockeyApp::Config.configure do |config|
      config.token = "ABCDEF"
      config.base_uri = "foobar"
    end
    hash = HockeyApp::Config.to_h
    hash.should == {
        :token => "ABCDEF",
        :base_uri => "foobar"
    }
  end

end