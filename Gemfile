source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'rails-api', '0.4.0'
# gem "codeclimate-test-reporter", group: :test, require: nil
# gem 'codecov', :require => false, :group => :test
gem "figaro"

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
end
