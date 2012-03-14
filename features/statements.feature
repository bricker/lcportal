#Feature: Statements
#	In order to keep myself up to date with my royalties
#	As a writer for Liquid Cinema
#	I want to be able to login to the portal to see my statements
#
#Background:
#	Given I am a writer
#	And I am logged in
#
#Scenario: See a paginated list of my royalty statements
#	Given I have 7 statements
#	When I go to the statements page
#	Then I should see my latest 5 statements listed
#	And I should see a link to view more statements
#
#Scenario: No Statements
#	Given I have 0 statements
#	When I go to the statements page
#	Then I should see a message notifying me that there is nothing to list
