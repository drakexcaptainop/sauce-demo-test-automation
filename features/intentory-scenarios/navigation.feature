Feature: Page Navigation and URL Routing
  As a standard user of the Swag Labs application
  I want to navigate through different sections of the website
  So that I can browse products, manage my cart, and complete purchases correctly

  Background:
    Given the user opens the browser and navigates to "https://www.saucedemo.com"

  Scenario: Navigation from Inventory to Product Detail and Back
    Given the user is logged in as "standard_user"
    And the user is on the Inventory page
    When the user clicks on the title of the first product
    Then the user should be taken to the product detail page
    And the URL should contain "/inventory-item.html"
    When the user clicks the "Back to products" button
    Then the user should be redirected back to the Inventory page

  Scenario: Navigation from Inventory to Cart and Back
    Given the user is logged in as "standard_user"
    And the user is on the Inventory page
    When the user clicks the shopping cart icon
    Then the user should be taken to the Cart page
    And the URL should contain "/cart.html"
    When the user clicks the "Continue Shopping" button
    Then the user should be redirected back to the Inventory page

  Scenario: Sidebar Menu Expansion
    Given the user is logged in as "standard_user"
    When the user clicks the "Burger Menu" icon
    Then the sidebar navigation panel should slide into view
    And the URL should not change
    And the menu options "All Items", "About", "Logout", "Reset App State" should be visible

  Scenario: Sidebar Navigation using "All Items"
    Given the user is logged in as "standard_user"
    And the user is currently on the Cart page
    When the user opens the sidebar menu
    And the user clicks the "All Items" link
    Then the user should be redirected to the Inventory page


  Scenario: External Link Navigation to About Page
    Given the user is logged in and the sidebar menu is open
    When the user clicks the "About" link
    Then the browser should navigate to "https://saucelabs.com/"

  Scenario: Page Refresh Persistence
    Given the user is logged in and on the Checkout Step Two page
    When the user refreshes the browser page
    Then the user should remain on the Checkout Step Two page

  Scenario: Unauthenticated Direct URL Access
    Given the user is NOT logged in
    When the user attempts to access "https://www.saucedemo.com/inventory.html" directly
    Then the user should be redirected to the login page
    And an error message "Epic sadface: You can only access '/inventory.html' when you are logged in" should be displayed
