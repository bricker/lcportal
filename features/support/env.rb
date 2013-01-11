require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  require 'cucumber/rails'
  require Rails.root.join "spec/support/mailer_macros.rb"
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  require 'cucumber/rspec/doubles'
  
  Cucumber::Rails::Database.javascript_strategy = :truncation
  include Factory::Syntax::Methods
  include MailerMacros
  
  Capybara.default_selector = :css
  ActionController::Base.allow_rescue = false
  DatabaseCleaner.strategy = :truncation

  After do |scenario|
    DatabaseCleaner.clean
    reset_email  
  end
end

Spork.each_run do
  DatabaseCleaner.clean
  FactoryGirl.reload
end

