# adapted from rspec-rails http://github.com/rspec/rspec-rails/blob/master/spec/rspec/rails/mocks/mock_model_spec.rb
# put this in a file in your spec/support directory
# USAGE:
#
# let(:model) { ModelUnderTest.new(params) }
# it_behaves_like "ActiveModel"

shared_examples_for "ActiveModel" do
  require 'test/unit/assertions'
  require 'active_model/lint'
  include Test::Unit::Assertions
  include ActiveModel::Lint::Tests

  ActiveModel::Lint::Tests.public_instance_methods.map { |method| method.to_s }.grep(/^test/).each do |method|
    example(method.gsub('_', ' ')) {
      send method
    }
  end
end