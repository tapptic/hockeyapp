# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "hockeyapp"
  s.version     = "0.0.17"
  s.authors     = ["Philippe Van Eerdenbrugghe", "Paul Renson"]
  s.email       = ["philippe.vaneerdenbrugghe@tapptic.com", "paul.renson.ext@tapptic.com"]
  s.homepage    = ""
  s.summary     = %q{Wrapper for the hockeyapp REST API}
  s.description = %q{This simple wrapper enables you to acces the hockeyapp REST API through simple ruby calls. You are rquired to configure a valid token before doing anyhting else}

  s.rubyforge_project = "hockeyapp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "rspec"
  s.add_runtime_dependency "simplecov"
  s.add_runtime_dependency "awesome_print"
  s.add_runtime_dependency "rake"
  s.add_runtime_dependency "multi_json"


  s.add_runtime_dependency "httmultiparty"""
  s.add_runtime_dependency "activemodel"

end
