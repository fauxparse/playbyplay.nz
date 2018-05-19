Feature: Write a review
  As a reviewer
  I want to write a review
  So that I can give my thoughts on a performance

@facebook
@javascript
Scenario: Write a review
  Given I am logged in
   When I visit the new review page
   Then I should be on the new review page
   When I fill in the production name with 'Romeo and Juliet'
    And I click the 'Next' button
    And I select yesterday as the performance date
    And I click the 'Next' button
    And I write my review
    And I click the 'Finish' button
    And I click the 'Submit now' button
   Then I should be on the home page
    And my review should be created
