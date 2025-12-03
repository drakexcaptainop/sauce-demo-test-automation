Feature: User Authentication
@logout
  Scenario Outline: User successfully logs out
    Given I am logged in as "<username>"
    When I click the top left Three bar button
    And I click the Logout sidebar button
    Then I should be redirected to the Login Page
    And the Login button should be visible
    And the Username and Password fields should be empty

    Examples:
      | username                |
      | standard_user           |
      | problem_user            |
      | performance_glitch_user |
      | visual_user             |
      | error_user             |