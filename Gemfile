# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.1'

gem 'httparty'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'rubocop', require: false
gem 'rubocop-rspec', require: false

group :development, :test do
  gem 'rspec-rails'
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
