HockeyApp gem
=============

This gem enables you to easily access the JSON Rest API of http://www.hockeyapp.net.

More info available on this API here : http://support.hockeyapp.net/kb/api


HOW-TO
======

1° Configure your connection :

```ruby
HockeyApp::Config.configure do |config|
  config.token = "ABCDEF"
end
```

2° Make a client

```ruby
client = HockeyApp.build_client
```

3° Use the client

```ruby
apps = client.get_apps
versions = apps.first.versions
crashes = apps.first.crashes
....
```

4° Read the specs for more use cases


