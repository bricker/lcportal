#### Admin Creation
Given /^I am an admin$/ do
  @user = create :admin, email: "admin@liquidcinema.com"
  @user.is_admin?.should be_true
end

Given /^(\d+) admins?$/ do |num|
  @admins = create_list :admin, num.to_i
  @admin = @admins[rand(@admins.length)]
end


#### Action
When /^I fill in the admin fields with invalid information$/ do
  fill_in "admin_name", with: ""
  fill_in "admin_email", with: ""
end

When /^I fill in the admin fields with valid information$/ do
  fill_in "admin_name", with: "Bryan Ricker"
  fill_in "admin_email", with: "bricker@liquidcinema.com"
end


#### Routing
When /^I go to the admins page$/ do
  visit admins_path
end

Then /^I should be on the admin's profile page$/ do
  current_path.should eq admin_path(@admin)
end


#### Finders
Then /^I should see a list of (\d+) admins?$/ do |num|
  page.should have_css ".list .admin", count: num.to_i
end

Then /^I should see the admin's information$/ do
  page.should have_content @admin.name
  page.should have_content @admin.email
end


#### Assertions
Then /^there should be (\d+) admins$/ do |num|
  Admin.all.count.should eq num.to_i
end

Then /^there should be a new admin$/ do
  @admin = Admin.last
end
