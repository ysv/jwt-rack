require "bundler/setup"
require "jwt/rack"
require 'rspec'
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
end
