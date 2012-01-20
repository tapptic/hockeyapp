require 'hockeyapp'

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

  it "can transform into a hash" do
    HockeyApp::Config.token = "ABCDEF"
    hash = HockeyApp::Config.to_h
    hash.should == {:token => "ABCDEF"}
  end

end