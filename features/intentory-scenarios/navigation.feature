Feature: Page Navigation and URL Routing
  As a standard user of the Swag Labs application
  I want to navigate through different sections of the website
  So that I can browse products, manage my cart, and complete purchases correctly

  Background:
    Given the user is logged in to Sauce Demo as "standard_user"
    And the user is in the Inventory page


  Scenario: Sidebar Menu Expansion
    When the user clicks the "Burger Menu" icon
    Then the sidebar navigation panel should slide into view
    And the followin menu options should be visible:
      | Option Name |
      | All Items  |
      | About |
      | Logout |
      | Reset App State |

  @navi-error
  Scenario: External Link Navigation to About Page
    When the user opens the sidebar menu
    And the user clicks the "About" link
    Then the browser should navigate to the Sauce Labs page

  Scenario: Page Refresh Persistence
    Given the user navigates to the "Checkout Step Two" page
    When the user refreshes the browser page
    Then the user should remain on the "Checkout Step Two" page

  @fixed-navi
  Scenario Outline: Navigate to product details
    When I click on the name of the product "<product_name>"
    Then I should be on the product details page
    And I should see the product title "<product_name>"
    And I should see the product description "<description>"
    And I should see the "Add to cart" button

    Examples:
      | product_name          | description |
      | Sauce Labs Backpack   | carry.allTheThings() with the sleek, streamlined Sly Pack that melds uncompromising style with unequaled laptop and tablet protection.            |
      | Sauce Labs Fleece Jacket   | It's not every day that you come across a midweight quarter-zip fleece jacket capable of handling everything from a relaxing day outdoors to a busy day at the office.       |
  
  @navi-error
  Scenario: Return to Inventory from Product Details
    Given I have opened the details for "Sauce Labs Backpack"
    When I click the "Back to products" button
    Then I should see the "Products" page

  Scenario: Open the shopping cart
    When I click the shopping cart icon
    Then I should see the "Your Cart" page
    And I should see the "Checkout" button

  Scenario: Return to Inventory from Cart
    Given I am on the "Your Cart" page
    When I click the "Continue Shopping" button
    Then I should see the "Products" page


Scenario Outline: Add items to the cart depending on user type
  Given I am logged in to Sauce Demo as "<user>"
  When I add all items to the cart
  Then the cart icon in the top right corner shows the number "<expected_count>" 

Examples:
| user                    | expected_count |
| standard_user           | 6              |
| visual_user             | 6              |
| problem_user            | 3              |
| error_user              | 3              |

@cart-visibility
Scenario Outline: Verify cart badge visibility after clearing items based on user type
  Given I am logged in to Sauce Demo as "<user>"
  When I add all items to the cart
  And I remove all items from the cart
  Then the item number on top of the cart icon should be "<expected_state>"

Examples:
  | user                    | expected_state |
  | standard_user           | hidden         |
  | visual_user             | hidden         |
  | problem_user            | 3              |
  | error_user              | 3              |