Feature: Logout
  Scenario: Logout from the application
    Given I am on the login page
    When I input username "standard_user" and password "secret_sauce"
    And I click the login button
    Then I should see the inventory page
    When I open the left sidebar menu and click "Logout"
    Then I should see the login page