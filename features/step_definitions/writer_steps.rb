#### Writer creation
Given /^I am a writer$/ do
  @user = create :writer
end

Given /^(\d+) writers?$/ do |num|
  @writers = create_list :writer, num.to_i
  @writer = @writers[rand(@writers.length)]
end


#### Routing
When /^I go to the writers page$/ do
  visit writers_path
end

When /^I go to the new writer page$/ do
  visit new_writer_path
end

When /^I go to the edit page for (?:that|a|the) writer$/ do
  visit edit_writer_path(@writer)
end

Then /^I should be on (?:that|the) writer's profile page$/ do
  current_path.should eq writer_path(@writer)
end

Then /^I should be on the writers page$/ do
  current_path.should eq writers_path
end


#### Finders
Then /^I should see a list of (\d+) writers$/ do |num|
  page.should have_css ".writer", count: num.to_i
end

Then /^the changes should be reflected on the writer's profile$/ do
  page.should have_content "123-456-7890"
  page.should have_content "Jane Writer"
end

Then /^I should see the writer's information$/ do
  page.should have_content @writer.name
  page.should have_content @writer.email
end


#### Actions
When /^I change some information$/ do
  fill_in 'writer_profile_attributes_phone_number', with: "123-456-7890"
  fill_in 'writer_name', with: "Jane Writer"
end

When /^I fill in the writer fields with invalid information$/ do
  fill_in "writer_name", with: ""
  fill_in "writer_email", with: ""
end

When /^I fill in the writer fields with valid information$/ do
  fill_in "writer_name", with: "Joe Writer"
  fill_in "writer_email", with: "jwriter@liquidcinema.com"
end


#### Assertions
Then /^an e\-mail should have been sent to the writer$/ do
  last_email.to.should eq [@writer.email]
end

Then /^there should be (\d+) writers?$/ do |num|
  Writer.all.count.should eq num.to_i
end

Then /^the writer should have a profile$/ do
  @writer.profile.should be_present
end

Then /^there should be a new writer$/ do
  @writer = Writer.last
  @writer.name.should eq "Joe Writer"
  @writer.email.should eq "jwriter@liquidcinema.com"
end