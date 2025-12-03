Feature: Cart Retention
@cart-retention
  Scenario Outline: Persistence of products in cart after logout
    Given I am logged in to Sauce Demo as "<user>"
    And I add the following products to the cart: "<products>"
    When I click the top left Three bar button
    And I click the Logout sidebar button
    Then I should be redirected to the Login Page
    When I log in again as "<user>"
    Then the cart icon in the top right corner shows the number "<count>"
    When I click the shopping cart icon
    Then the Your Cart page should display the products "<products>"

    Examples:
      | user | products                                  | count |
      | standard_user | Sauce Labs Backpack,Sauce Labs Bike Light | 2     |
      | performance_glitch_user | Sauce Labs Backpack,Sauce Labs Bike Light | 2     |
      | visual_user | Sauce Labs Backpack,Sauce Labs Bike Light | 2     |