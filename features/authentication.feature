Feature: Authentication
  As a reviewer
  I want to log in
  So that I can submit reviews

@facebook
Scenario: Log in as a new user
  Given I have never logged in
   When I visit the login page
    And I log in with Facebook
   Then I should be on the home page
    And I should be logged in

@facebook
Scenario: Log out
  Given I am logged in
   When I visit the home page
    And I click the logout link
   Then I should be on the home page
    And I should be logged out
