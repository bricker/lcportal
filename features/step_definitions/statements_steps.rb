#### Statement Creation
Given /^I have (\d+) statements$/ do |num|
  create_list :statement, num.to_i, writer: @writer 
end


#### Finders
Then /^I should see my latest (\d+) statements listed$/ do |num|
  page.should have_css ".statement", count: num.to_i
end

Then /^I should see a link to view more statements$/ do
  page.should have_css ".pagination"
end

Then /^I should see a list of statements$/ do
  page.should have_css ".list .statement"
end


#### Routing
Then /^I should be on the statements page$/ do
  current_path.should eq statements_path
end

When /^I go to the statements page$/ do
  visit statements_path
  current_path.should eq statements_path
end

Then /^I should be redirected to the statements page$/ do
  current_path.should eq statements_path
end
