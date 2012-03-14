require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  require 'cucumber/rails'
  require Rails.root.join "spec/support/mailer_macros.rb"
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  
  Cucumber::Rails::Database.javascript_strategy = :truncation
  include Factory::Syntax::Methods
  include MailerMacros
  
  Capybara.default_selector = :css
  ActionController::Base.allow_rescue = false
  
  begin
    DatabaseCleaner.strategy = :truncation
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end
  
  After do |scenario|
    DatabaseCleaner.clean
    reset_email
  end
end

Spork.each_run do
  FactoryGirl.reload
  LCPortal::Application.reload_routes!
end

