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

@facebook
Scenario: Click a link requiring authentication
  Given I have never logged in
   When I visit the home page
    And I choose to add a review
   Then I should be taken to the login page
   When I log in with Facebook
   Then I should be on the new review page

@facebook
@javascript
Scenario: Log in with Javascript enabled
  Given I have never logged in
   When I visit the home page
    And I choose to add a review
   When I log in with Facebook
   Then I should be on the new review page
