Feature: Manage Writers
	In order to keep the list of writers up-to-date
	An Admin
	Should be able to manage the writers in the portal

Background:
	Given I am an admin
	And I am logged in

Scenario: No writers
	Given 0 writers
	When I go to the writers page
	Then I should see a message that there is nothing to list
	
Scenario: See a list of writers
	Given 5 writers
	When I go to the writers page
	Then I should see a list of 5 writers
	And I should see management links

Scenario: Add a writer
	When I go to the writers page
	And I click the "New" link
	Then I should see the "new writer" form
	When I fill in the writer fields with valid information
	And I submit the form
	Then I should see a success message
	And there should be a new writer
	And I should be on the writer's profile page
	And an e-mail should have been sent to the writer
	And I should see the writer's information
	And the writer should have a profile
	And there should be 1 writer
	
Scenario: Attempt to add a writer with invalid fields
	When I go to the new writer page
 	And I fill in the writer fields with invalid information
	And I submit the form
	Then I should see the "new writer" form
	And I should be notified of errors
	And there should be 0 writers
	And there should be 0 profiles
	
Scenario: Edit a writer
	Given 1 writer
	When I go to the edit page for that writer
	Then I should see profile fields
	When I change some information
	And I submit the form
	Then I should see a success message
	And I should be on that writer's profile page
	And the changes should be reflected on the writer's profile

Scenario: Remove a writer
	Given 2 writers
	When I go to the writers page
	And I click the "Destroy" link
	Then I should be on the writers page
	And I should see a success message
	And there should be 1 writer
	When I go to the edit page for a writer
	And I click the "Destroy" link
	Then I should be on the writers page
	And I should see a success message
	And there should be 0 writers