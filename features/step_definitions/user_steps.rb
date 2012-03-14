#### Setup
Given /^I am a user$/ do
  @user = create :user
end

Given /^(\d+) users?$/ do |num|
  @users = create_list :user, num.to_i
  @user = @users[rand(@users.length)]
end
