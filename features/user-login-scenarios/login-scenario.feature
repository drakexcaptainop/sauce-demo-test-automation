Feature: User Login
  Scenario: Standard User Login
    Given I am on the login page
    When I input username "standard_user" and password "secret_sauce"
    And I click the login button
    Then I should see the following products on the inventory page:
      | Sauce Labs Backpack               |
      | Sauce Labs Bike Light             |
      | Sauce Labs Bolt T-Shirt           |
      | Sauce Labs Fleece Jacket          |
      | Sauce Labs Onesie                 |
      | Test.allTheThings() T-Shirt (Red) |

  Scenario: Problem User Login
    Given I am on the login page
    When I input username "problem_user" and password "secret_sauce"
    And I click the login button
    Then I should see the following products on the inventory page:
      | Sauce Labs Backpack               |
      | Sauce Labs Bike Light             |
      | Sauce Labs Bolt T-Shirt           |
      | Sauce Labs Fleece Jacket          |
      | Sauce Labs Onesie                 |
      | Test.allTheThings() T-Shirt (Red) |

  Scenario: Locked Out User Login
    Given I am on the login page
    When I input username "locked_out_user" and password "secret_sauce"
    And I click the login button
    Then I should see the error message "Epic sadface: Sorry, this user has been locked out."

  Scenario: Invalid User Login
    Given I am on the login page
    When I input username "invalid_user" and password "wrong_pass"
    And I click the login button
    Then I should see the error message "Epic sadface: Username and password do not match any user in this service"

  Scenario: Visual User Login
    Given I am on the login page
    When I input username "visual_user" and password "secret_sauce"
    And I click the login button
    Then I should see the following products on the inventory page:
      | Sauce Labs Backpack               |
      | Sauce Labs Bike Light             |
      | Sauce Labs Bolt T-Shirt           |
      | Sauce Labs Fleece Jacket          |
      | Sauce Labs Onesie                 |
      | Test.allTheThings() T-Shirt (Red) |

  Scenario: Performance Glitch User Login
    Given I am on the login page
    When I input username "performance_glitch_user" and password "secret_sauce"
    And I click the login button
    Then I should see the following products on the inventory page:
      | Sauce Labs Backpack               |
      | Sauce Labs Bike Light             |
      | Sauce Labs Bolt T-Shirt           |
      | Sauce Labs Fleece Jacket          |
      | Sauce Labs Onesie                 |
      | Test.allTheThings() T-Shirt (Red) |