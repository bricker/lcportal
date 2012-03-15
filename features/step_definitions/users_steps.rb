#### Setup
Given /^I am a user$/ do
  @user = create :user
end

Given /^a user with e\-mail "([^"]*)"$/ do |email|
  @user = create :user, email: email
end