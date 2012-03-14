#### Routing
When /^I go to the forgot password page$/ do
  visit new_password_reset_path
end

When /^I follow the link that was e\-mailed to me$/ do
  visit edit_password_reset_path(@user.reload.password_reset_token)
end

When /^I go to reset my password$/ do
  path = edit_password_reset_path(@user.reload.password_reset_token)
  visit path
  current_path.should eq path
end


#### Actions
When /^I fill in the field with an invalid e\-mail$/ do
  fill_in "email", with: "non-existant-email@gmail.com"
end

When /^I fill in the field with a valid e\-mail$/ do
  fill_in "email", with: @user.email
end

When /^I fill in the login fields with my new information$/ do
  fill_in "email", with: @user.email
  fill_in "password", with: "New Password"
end

When /^I request a password reset$/ do
  visit new_password_reset_path
  fill_in "email", with: @user.email
  find("input[type=submit]").click
end

When /^I fill in a valid password and matching confirmation$/ do
  fill_in "user_password", with: "New Password"
  fill_in "user_password_confirmation", with: "New Password"
end

When /^I fill in a password and a mismatching confirmation$/ do
  fill_in "user_password", with: "New Password"
  fill_in "user_password_confirmation", with: "Mismatched"
end


#### Assertions
Then /^an e\-mail should have been sent to the address I filled in$/ do
  last_email.to.should eq [@user.email]
end

Then /^I should have a new password$/ do
  BCrypt::Password.new(@user.reload.password_digest).should eq "New Password"
end

