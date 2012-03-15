Feature: Users

Scenario: Add a user with a duplicate e-mail
	Given I am logged in as an admin
	And a user with e-mail "bryan@liquidcinema.com"
	When I go to the new writer page
	And I fill in "writer e-mail" with "bryan@liquidcinema.com"
	And I submit the form
	Then I should see the "new writer" form
	And I should be notified of errors
	When I go to the new admin page
	And I fill in "admin e-mail" with "bryan@liquidcinema.com"
	And I submit the form
	Then I should see the "new admin" form
	And I should be notified of errors