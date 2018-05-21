Feature: Moderate a submitted review
  As a moderator
  I want to moderate reviews before they are published
  So that I can ensure the quality of the site is consistent

@facebook
Scenario: Approve a review
  Given I am logged in as a moderator
    And there is a pending submission
   When I visit the submissions page
    And I click on the submission
    And I fill in my feedback
    And I click the 'Approve' button
   Then I should be on the submissions page
    And I should see confirmation that the submission was approved
    And I should not see the submission
    And the review should be published
