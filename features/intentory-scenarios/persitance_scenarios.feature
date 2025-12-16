Feature: Cart Retention
@cart-retention
  Scenario Outline: Persistence of products in cart after logout
    Given I am logged in to Sauce Demo as "<user>"
    And I have added the following products to the cart:
      | Product Name          |
      | Sauce Labs Backpack   |
      | Sauce Labs Bike Light |
    When I log out of the application
    And I log in again as "<user>"
    And I click the shopping cart icon
    Then the Your Cart page should display the products:
      | Product Name          |
      | Sauce Labs Backpack   |
      | Sauce Labs Bike Light |

    Examples:
      | user |
      | standard_user |
      | performance_glitch_user |
      | visual_user |