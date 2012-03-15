Feature: Authentication
	In order to manage things in the portal
	A User
	Should be able to login to and logout of the portal

Scenario: Show login form
	Given I am logged out
	When I go to the login page
	Then I should see the "login" form
	And I should not be logged in
	
Scenario: Fill in incorrect information
	Given I am logged out
	Given I am a user
	When I go to the login page
	And I fill in the login fields with invalid information
	And I submit the form
	Then I should see a failure message
	And I should see the "login" form
	And I should not be logged in
	
Scenario: Login to the portal as a writer
	Given I am a writer
	And I am logged out
	When I go to the login page
	And I fill in the login fields with valid information
	And I submit the form
	Then I should see a success message
	And I should be on the statements page
	
Scenario: Login to the portal as an admin
	Given I am an admin
	And I am logged out
	When I go to the login page
	And I fill in the login fields with valid information
	And I submit the form
	Then I should see a success message
	And I should be on the statements page
	
Scenario: Visit login page while already logged in
	Given I am logged in
	When I go to the login page
	Then I should be redirected to the statements page
	
Scenario: Logout
	Given I am logged in
	When I click the "logout" link
	Then I should see a success message
	And I should be on the login page
	And I should not be logged in
