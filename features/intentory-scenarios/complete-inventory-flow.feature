Feature: Complete Inventory Flow with standard_user and performance_glitch_user
  Scenario Outline: End-to-end checkout total calculation validation for standard_user and performance_glitch_user with different product sets
    Given I am logged in to Sauce Demo as "<user>"
    And I am in the Products page
    When I add the following products to the cart: "<products>"
    And I click the shopping cart icon
    And I click the Checkout button
    Then I should see the "Checkout: Your Information" page
    When I fill the checkout info with "Test", "User", "12345"
    And I click Continue
    Then I should see the "Checkout: Overview" page
    And the "Item total" field should show "<item_total>"
    And the "Tax" field should show "<tax>"
    And the "Total" field should show "<total>"
    When I click Finish
    Then I should see the "Thank you for your order!" text message
    Examples:
    | user  | products                                  | item_total | tax   | total |
    | standard_user | Sauce Labs Backpack,Sauce Labs Bike Light | 39.98      | 3.20  | 43.18 |
    | standard_user | Sauce Labs Bolt T-Shirt,Sauce Labs Onesie | 23.98      | 1.92  | 25.90 |
    | performance_glitch_user | Sauce Labs Bolt T-Shirt,Sauce Labs Onesie | 23.98      | 1.92  | 25.90 |
    | performance_glitch_user | Sauce Labs Backpack,Sauce Labs Bike Light | 39.98      | 3.20  | 43.18 |