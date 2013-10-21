# HockeyApp gem

This gem enables you to easily access the JSON Rest API of [http://www.hockeyapp.net](http://www.hockeyapp.net).

More info available on this API here : [http://support.hockeyapp.net/kb/api](http://support.hockeyapp.net/kb/api)


## HOW-TO

1° Configure your connection :

    HockeyApp::Config.configure do |config|
      config.token = "ABCDEF"
    end

2° Make a client

    client = HockeyApp.build_client

3° Use the client

    apps = client.get_apps
    versions = apps.first.versions
    crashes = apps.first.crashes
    ....

4° Read the specs for more use cases

## Methods implemented

- Client#get_apps
- Client#get_crashes app
- Client#get_crash_groups app
- Client#get_crash_log crash
- Client#get_crash_description
- Client#get_versions
- Client#post_new_version version
- Client#remove_versions app, options={}
- Client#remove_app app
- Client#create_app file_ipa
- Client#list_users app, options={}
- Client#invite_user app, options={}


