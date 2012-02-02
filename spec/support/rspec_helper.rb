require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'

  add_group 'Models', '/models/'
  add_group 'Webservice', '/ws/'
end


require 'hockeyapp'
require_relative 'fake_ws'
require_relative 'active_model_lint'





