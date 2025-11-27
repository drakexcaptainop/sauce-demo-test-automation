
Feature: Inventory Actions

  Scenario Outline: Login and add specific items to the shopping cart
    Given I am on the login page
    And I input username "standard_user" and password "secret_sauce"
    And I click the login button

    When I click "Add to cart" for the product "<product_name>"

    Then the shopping cart badge should show "<count>"
    And the button for "<product_name>" should change to "Remove"

    Examples:
      | product_name            | count |
      | Sauce Labs Backpack     | 1     |
      | Sauce Labs Bike Light   | 1     |
      | Sauce Labs Bolt T-Shirt | 1     |

 Scenario: Add an item to the cart
   Given I am logged in to Sauce Demo as "standard_user"
   When I add "Sauce Labs Backpack" to the cart
   Then the cart badge shows "1"

 Scenario: Complete a purchase successfully
   Given I am logged in to Sauce Demo as "standard_user"
   And I add "Sauce Labs Bike Light" to the cart
   When I go to the shopping cart
   And I proceed to checkout
   And I fill the checkout info with "Juan", "Perez", "12345"
   And I finish the order
   Then I see the order success message "Thank you for your order!"