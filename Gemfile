source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'rails-api', '0.4.0'
gem "figaro"
gem 'devise_token_auth'
gem 'omniauth'
gem 'rack-cors', :require => 'rack/cors'


group :production do
  gem 'rails_12factor'
  gem 'pg', "0.18.1"
end

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'spring'
  gem 'web-console', '~> 2.0'
  gem 'pry-rails'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
  gem 'simplecov', :require => false
  gem 'codecov', :require => false
  gem "codeclimate-test-reporter"
  gem 'json_spec', '~> 1.1', '>= 1.1.4'
end
