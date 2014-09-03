require 'simplecov'
SimpleCov.start do
  root File.expand_path('../..', File.dirname(__FILE__))
  add_filter '/spec/'

  add_group 'Models', '/models/'
  add_group 'Webservice', '/ws/'
end


require 'hockeyapp'
require 'minitest/autorun'
require_relative 'fake_ws'
require_relative 'active_model_lint'





