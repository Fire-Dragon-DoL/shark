# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'bcrypt', '~> 3.1'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.1'
gem 'redis', '~> 4.1'

group :development, :test do
  gem 'pry-byebug'
end

group :development do
  gem 'rubocop', '~> 0.84.0', require: false
  gem 'rubocop-rails', '~> 2.5.2', require: false
end
