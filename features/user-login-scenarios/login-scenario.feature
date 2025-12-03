Feature: User Login

  Scenario: Standard User Login
    Given I am on the login page
    When I input username "standard_user" and password "secret_sauce"
    And I click the login button
    Then I should see the following products and prices on the inventory page:
      | Sauce Labs Backpack               | $29.99 |
      | Sauce Labs Bike Light             | $9.99  |
      | Sauce Labs Bolt T-Shirt           | $15.99 |
      | Sauce Labs Fleece Jacket          | $49.99 |
      | Sauce Labs Onesie                 | $7.99  |
      | Test.allTheThings() T-Shirt (Red) | $15.99 |
@problem
  Scenario: Problem User Login
    Given I am on the login page
    When I input username "problem_user" and password "secret_sauce"
    And I click the login button
    Then I should see the following products and prices on the inventory page:
      | Sauce Labs Backpack               | $29.99 |
      | Sauce Labs Bike Light             | $9.99  |
      | Sauce Labs Bolt T-Shirt           | $15.99 |
      | Sauce Labs Fleece Jacket          | $49.99 |
      | Sauce Labs Onesie                 | $7.99  |
      | Test.allTheThings() T-Shirt (Red) | $15.99 |
    And all products should display the dog image

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

  @visual
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
    And the product "Sauce Labs Backpack" should display the dog image

  Scenario: Performance Glitch User Login
    Given I am on the login page
    When I input username "performance_glitch_user" and password "secret_sauce"
    And I click the login button
    Then I should see the following products and prices on the inventory page:
      | Sauce Labs Backpack               | $29.99 |
      | Sauce Labs Bike Light             | $9.99  |
      | Sauce Labs Bolt T-Shirt           | $15.99 |
      | Sauce Labs Fleece Jacket          | $49.99 |
      | Sauce Labs Onesie                 | $7.99  |
      | Test.allTheThings() T-Shirt (Red) | $15.99 |
@error
 Scenario: Error User Login
    Given I am on the login page
    When I input username "error_user" and password "secret_sauce"
    And I click the login button
    Then I should see the following products and prices on the inventory page:
      | Sauce Labs Backpack               | $29.99 |
      | Sauce Labs Bike Light             | $9.99  |
      | Sauce Labs Bolt T-Shirt           | $15.99 |
      | Sauce Labs Fleece Jacket          | $49.99 |
      | Sauce Labs Onesie                 | $7.99  |
      | Test.allTheThings() T-Shirt (Red) | $15.99 |