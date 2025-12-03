Feature: Cart Retention
@cart-retention
  Scenario Outline: Persistence of products in cart after logout
    Given I am logged in to Sauce Demo as "standard_user"
    And I add the following products to the cart: "<products>"
    When I click the top left Three bar button
    And I click the Logout sidebar button
    Then I should be redirected to the Login Page
    When I log in again as "standard_user"
    Then the cart icon in the top right corner shows the number "<count>"
    When I click the shopping cart icon
    Then the Your Cart page should display the products "<products>"

    Examples:
      | products                                  | count |
      | Sauce Labs Backpack,Sauce Labs Bike Light | 2     |