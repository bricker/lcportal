source 'http://rubygems.org'

gem 'rails'
gem 'kaminari'
gem 'paperclip', "~> 2.7.0"
gem 'jquery-rails'
gem 'bcrypt-ruby'
gem 'simple_form'
gem 'aws-sdk', "~> 1.3.6"

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'twitter-bootstrap-rails'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'guard'
  gem 'spork'
  gem 'guard-spork'
  gem 'guard-cucumber'
  gem 'guard-rspec'
  gem 'launchy' 
  gem 'rb-fsevent', require: false
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'cucumber'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'fakeweb'
end

# HEROKU
group :production do
  gem 'pg'
end