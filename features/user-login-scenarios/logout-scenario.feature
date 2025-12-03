Feature: User Authentication

  Scenario: Standard User successfully logs out
    Given I am logged in as "standard_user"
    When I click the top left Three bar button
    And I click the Logout sidebar button
    Then I should be redirected to the Login Page
    And the Login button should be visible
    And the Username and Password fields should be empty