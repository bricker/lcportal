Feature: Admins
	In order to allow someone to manage the portal
	An admin
	Should be able to manage other admin accounts

Background:
	Given I am an admin
	And I am logged in

Scenario: See a list of admins
	Given 5 admins
	When I go to the admins page
	Then I should see a list of 6 admins
	And I should see management links
	
Scenario: Add an admin
	When I go to the admins page
	And I click the "New" link
	Then I should see the "new admin" form
	When I fill in the admin fields with valid information
	And I submit the form
	Then I should see a success message
	And there should be a new admin
	And I should be on the admin's profile page
	And an e-mail should have been sent to the user
	And I should see the admin's information
	And there should be 2 admins