Feature: As a BDD fanatic
         I want to start writing my tests
         so I learn more about automation


# --- ESCENARIOS SAUCE DEMO ---
 

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