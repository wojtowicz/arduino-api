# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/vendor/gems/'
end
SimpleCov.minimum_coverage 100

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'rspec/rails'
require 'webmock/rspec'
require 'database_cleaner'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort
                                                     .each { |f| require f }

RSpec.configure do |config|
  config.include Helpers
  config.include JsonSpec::Helpers
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
