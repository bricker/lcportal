Feature: Reset Password
	If a user forgets his/her password
	That user
	Should be able to reset the password
	
Background:
	And I am logged out

Scenario: Visit the forgot password form
	When I go to the login page
	And I click the "Forgot Password" link
	Then I should see the "forgot password" form

Scenario: Request a password reset with an invalid e-mail
	Given I am a user
	When I go to the forgot password page
	And I fill in the field with an invalid e-mail
	And I submit the form
	Then I should see a failure message
	And I should be on the forgot password page
	And an e-mail should not have been sent

Scenario: Request a password reset with a valid e-mail
	Given I am a user
	When I go to the forgot password page
	And I fill in the field with a valid e-mail
	And I submit the form
	Then I should see a success message
	And I should be on the login page
	And an e-mail should have been sent to the address I filled in

Scenario: Visit password reset form with invalid token
	Given I am a user
	When I request a password reset
	And I visit the password reset page with an invalid token
	Then I should be on the login page
	And I should see a failure message
		
Scenario: Visit password reset form with valid token
	Given I am a user
	When I request a password reset
	And I follow the link that was e-mailed to me
	Then I should see the "password reset" form

Scenario: Mismatching password as writer
	Given I am a writer
	When I request a password reset 
	And I go to reset my password
	And I fill in a password and a mismatching confirmation
	And I submit the form
	Then I should see the "password reset" form
	And I should be notified of errors
	
Scenario: Mismatching password as admin
	Given I am an admin
	When I request a password reset 
	And I go to reset my password
	And I fill in a password and a mismatching confirmation
	And I submit the form
	Then I should see the "password reset" form
	And I should be notified of errors
	
Scenario: Reset Password as writer
	Given I am a writer
	When I request a password reset
	And I go to reset my password
	And I fill in a valid password and matching confirmation
	And I submit the form
	Then I should see a success message
	And I should be on the login page
	And I should have a new password
	When I fill in the login fields with my new information
	And I submit the form
	Then I should see a success message
	And I should be logged in
	
Scenario: Reset Password as admin
	Given I am an admin
	When I request a password reset
	And I go to reset my password
	And I fill in a valid password and matching confirmation
	And I submit the form
	Then I should see a success message
	And I should be on the login page
	And I should have a new password
	When I fill in the login fields with my new information
	And I submit the form
	Then I should see a success message
	And I should be logged in
