Feature: Write a review
  As a reviewer
  I want to write a review
  So that I can give my thoughts on a performance

@facebook
Scenario: My first review
  Given I have never logged in
   When I visit the home page
    And I choose to add a review
   Then I should be taken to the login page
   When I log in with Facebook
   Then I should be on the new review page
