# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'pg'
gem 'puma', '~> 4.3'
gem 'rack-cors'
gem 'rails', '~> 6.0.2'
gem 'responders'

gem 'attr_encrypted', '~> 3.1.0'
gem 'httparty'
gem 'jbuilder'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'rubocop', require: false
gem 'rubocop-rspec', require: false

group :test do
  gem 'database_cleaner'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'factory_bot_rails'
  gem 'json_spec'
  gem 'rspec-rails'
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'travis'
  gem 'web-console', '>= 3.3.0'
end
