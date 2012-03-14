#### Finders
Then /^I should see a message notifying me that there is nothing to list$/ do
  page.should have_css ".no-records-message"
end

Then /^I should see a success message$/ do
  page.should have_css ".alert-success"
end

Then /^I should see a failure message$/ do
  page.should have_css ".alert-error"
end

Then /^I should see (?:a )?management links?$/ do
  page.should have_css ".manage a"
end

Then /^I should be notified of errors$/ do
  page.should have_css ".help-inline"
end

Then /^I should see the "([^"]*)" form$/ do |text|
  page.should have_css "form##{text.gsub(/\s/, '_')}"
end

Then /^I should see a message that there is nothing to list$/ do
  page.should have_css '.none-to-list'
end


#### Routing
Then /^I should be on the home page$/ do
  current_path.should eq root_path
end


#### Actions
When /^I click the "([^"]*)" link$/ do |text|
  click_link text.to_s
end

Then /^I submit the form$/ do
  find("input[type=submit]").click
end


#### Assertions
Then /^an e\-mail should have been sent to the user$/ do
  last_email.to.should eq [User.last.email]
end

Then /^an e\-mail should not have been sent$/ do
  ActionMailer::Base.deliveries.length.should eq 1 # The e-mail sent to the user created at the beginning of the scenario
end

Then /^the list should be paginated$/ do
  page.should have_css ".pagination"
end