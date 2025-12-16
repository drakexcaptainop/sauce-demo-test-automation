Feature: Complete Inventory Flow with standard_user and performance_glitch_user
  Scenario Outline: End-to-end checkout total calculation validation for standard_user and performance_glitch_user with different product sets
    Given I am logged in to Sauce Demo as "<user>"
    And I am in the Products page
    And I have added the following products to the cart:
      | Product Name          |
      | Sauce Labs Backpack   |
      | Sauce Labs Bike Light |
    When I click the shopping cart icon
    And I click the Checkout button
    And I fill the checkout info with:
      | First Name | Test |
      | Last Name  | User |
      | Zip Code   | 12345 |
    And I click Continue
    And I click Finish
    Then I should see the "Checkout: Complete!" page
    And the "Thank you for your order!" text message should be visible
    And the "Back Home" button should be visible
    Examples:
    | user  |                                
    | standard_user | 
    | performance_glitch_user | 


    