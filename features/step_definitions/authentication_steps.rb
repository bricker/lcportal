#### Setup
Given /^I am logged in$/ do
  @user ||= create :user
  visit login_path
  fill_in 'email', with: @user.email
  fill_in 'password', with: @user.password
  find("input[type=submit]").click
  current_path.should eq statements_path
  page.should have_css ".alert-success"
end

Given /^I am logged out$/ do
  visit logout_path
  page.should_not have_css "ul.nav"
  current_path.should eq login_path
end


#### Routing
Then /^I should be on the login page$/ do
  current_path.should eq login_path
end

When /^I go to the login page$/ do
  visit login_path
end


#### Finders
Then /^I should not see a logout link$/ do
  page.should_not have_css '#logout'
end


#### Assertions
Then /^I should be logged in$/ do
  page.should have_css "ul.nav"
end

Then /^I should not be logged in$/ do
  page.should_not have_css "ul.nav"
end


#### Actions
When /^I fill in the login fields with invalid information$/ do
  fill_in 'email', with: @user.email
  fill_in 'password', with: 'incorrect'
end

When /^I fill in the login fields with valid information$/ do
  fill_in "email", with: @user.email
  fill_in "password", with: "secret"
end
