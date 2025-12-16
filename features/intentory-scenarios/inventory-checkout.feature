Feature: Inventory Checkout

@standard-checkout
Scenario Outline: Standard User Checkout Calculation
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

    Then I should see the "Checkout: Overview" page
    And I should see the following payment calculations:
      | Field      | Value |
      | Item total | 39.98 |
      | Tax        | 3.20  |
      | Total      | 43.18 |

    Examples:
    | user                    |
    | standard_user           |
    | performance_glitch_user |


  @problem-checkout
  Scenario: Problem User fails to proceed past Checkout Information
    Given I am logged in to Sauce Demo as "problem_user"
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
    Then I should remain on the "Checkout: Your Information" page
    And I should see the error message "Error: Last Name is required" at the bottom of the form 

@visual-checkout
  Scenario Outline: Standard User Checkout Calculation
    Given I am logged in to Sauce Demo as "visual_user"
    And I am in the Products page
    And I have added the following products to the cart:
      | Product Name          |
      | Sauce Labs Backpack   |
      | Sauce Labs Bike Light |
    When I click the shopping cart icon
    And I click the Checkout button on the top right corner of the page
    And I fill the checkout info with:
      | First Name | Test |
      | Last Name  | User |
      | Zip Code   | 12345 |
    And I click Continue
    Then I should see the "Checkout: Overview" page
    And I should see the following payment calculations:
      | Field      | Value |
      | Item total | 39.98 |
      | Tax        | 3.20  |
      | Total      | 43.18 |


@error_checkout
  Scenario: Error User fails to complete the checkout
    Given I am logged in to Sauce Demo as "error_user"
    And I am in the Products page
    And I have added the following products to the cart:
      | Product Name          |
      | Sauce Labs Backpack   |
      | Sauce Labs Bike Light |
      | Sauce Labs Onesie |
    When I click the shopping cart icon
    And I click the Checkout button
    And I fill the checkout info with:
      | First Name | Test |
      | Last Name  | User |
      | Zip Code   | 12345 |
    When I click Continue
    Then the empty Last Name field should not give me an error 
    And I should see the "Checkout: Overview" page
    And I should see the following payment calculations:
      | Field      | Value |
      | Item total | 47.97 |
      | Tax        | 3.84 |
      | Total      | 51.81 |