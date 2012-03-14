source 'http://rubygems.org'

gem 'rails'
gem 'kaminari'
gem 'paperclip'
gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'simple_form'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'twitter-bootstrap-rails'
end

group :test, :development do
  gem 'sqlite3'
  
  gem 'rspec-rails'
  gem 'spork'  
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'launchy'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

group :production do
  gem 'pg'
end