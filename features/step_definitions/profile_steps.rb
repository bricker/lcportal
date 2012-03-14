#### Routing
When /^I go to my profile page$/ do
  visit profile_path
end


#### Finders
Then /^I should see my information$/ do
  page.should have_css "#profile"
end

Then /^the changes should be reflected on my profile page$/ do
  visit profile_path
  page.should have_content "new-email@liquidcinema.com"
end

Then /^I should see profile fields$/ do
  page.should have_css "#writer_profile_attributes_address"
  page.should have_css "#writer_profile_attributes_phone_number"
end


#### Actions
When /^I change some information on my profile$/ do
  visit edit_profile_path
  fill_in "writer_email", with: "new-email@liquidcinema.com"
  find("input[type=submit]").click
  current_path.should eq profile_path
end


#### Assertions
Then /^there should be (\d+) profiles$/ do |num|
  Profile.all.count.should eq num.to_i
end

