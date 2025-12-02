Feature: Page Navigation and URL Routing
  As a standard user of the Swag Labs application
  I want to navigate through different sections of the website
  So that I can browse products, manage my cart, and complete purchases correctly

  Background:
    Given the user opens the browser and navigates to "https://www.saucedemo.com"

  # 1. Successful Login Navigation
  Scenario: Successful Login Navigation
    Given the user is on the login page
    When the user enters the username "standard_user"
    And the user enters the password "secret_sauce"
    And the user clicks the "Login" button
    Then the user should be redirected to the Inventory page
    And the URL should contain "/inventory.html"
    And the product grid should be visible

  # 2. Failed Login Navigation Guard
  Scenario: Failed Login Navigation Guard
    Given the user is on the login page
    When the user enters an invalid username or password
    And the user clicks the "Login" button
    Then the user should remain on the login page
    And the URL should remain "https://www.saucedemo.com/"
    And an error message container should be displayed

  # 3. Navigation: Inventory to Product Detail and Back
  Scenario: Navigation from Inventory to Product Detail and Back
    Given the user is logged in as "standard_user"
    And the user is on the Inventory page
    When the user clicks on the title of the first product
    Then the user should be taken to the product detail page
    And the URL should contain "/inventory-item.html"
    When the user clicks the "Back to products" button
    Then the user should be redirected back to the Inventory page

  # 4. Navigation: Inventory to Cart and Back
  Scenario: Navigation from Inventory to Cart and Back
    Given the user is logged in as "standard_user"
    And the user is on the Inventory page
    When the user clicks the shopping cart icon
    Then the user should be taken to the Cart page
    And the URL should contain "/cart.html"
    When the user clicks the "Continue Shopping" button
    Then the user should be redirected back to the Inventory page

  # 5. Sidebar Menu Expansion
  Scenario: Sidebar Menu Expansion
    Given the user is logged in as "standard_user"
    When the user clicks the "Burger Menu" icon
    Then the sidebar navigation panel should slide into view
    And the URL should not change
    And the menu options "All Items", "About", "Logout", "Reset App State" should be visible

  # 6. Sidebar Navigation: "All Items"
  Scenario: Sidebar Navigation using "All Items"
    Given the user is logged in as "standard_user"
    And the user is currently on the Cart page
    When the user opens the sidebar menu
    And the user clicks the "All Items" link
    Then the user should be redirected to the Inventory page

  # 7. Full Checkout Flow Navigation
  Scenario: Full Checkout Flow Navigation
    Given the user is logged in and has at least one item in the cart
    And the user is on the Cart page
    When the user clicks the "Checkout" button
    Then the user should be on the Checkout Step One page "/checkout-step-one.html"
    When the user enters valid checkout information and clicks "Continue"
    Then the user should be on the Checkout Step Two page "/checkout-step-two.html"
    When the user clicks the "Finish" button
    Then the user should be on the Checkout Complete page "/checkout-complete.html"

  # 8. Checkout Cancellation Navigation
  Scenario: Checkout Cancellation Navigation
    Given the user is logged in and on the Checkout Information page
    When the user clicks the "Cancel" button
    Then the user should be redirected back to the Cart page

  # 9. Post-Purchase Navigation ("Back Home")
  Scenario: Post-Purchase Navigation Back Home
    Given the user is on the Checkout Complete page
    When the user clicks the "Back Home" button
    Then the user should be redirected to the Inventory page

  # 10. External Link Navigation (Sidebar)
  Scenario: External Link Navigation to About Page
    Given the user is logged in and the sidebar menu is open
    When the user clicks the "About" link
    Then the browser should navigate to "https://saucelabs.com/"

  # 11. Logout Navigation
  Scenario: Logout Navigation
    Given the user is logged in
    When the user opens the sidebar menu
    And the user clicks the "Logout" link
    Then the user should be redirected to the login page
    And the login form should be displayed

  # 12. Browser Back Button Functionality
  Scenario: Browser Back Button Functionality
    Given the user has navigated from the Inventory page to the Cart page
    When the user clicks the browser's "Back" button
    Then the user should be returned to the Inventory page

  # 13. Browser Forward Button Functionality
  Scenario: Browser Forward Button Functionality
    Given the user has navigated from Inventory to Cart and clicked Back
    When the user clicks the browser's "Forward" button
    Then the user should be returned to the Cart page

  # 14. Filter State Navigation (View Change)
  Scenario: Filter State Navigation
    Given the user is on the Inventory page
    When the user selects "Name (Z to A)" from the sort dropdown
    Then the product order should update
    And the URL should remain "/inventory.html"
    And the page should not reload

  # 15. Closing Sidebar Menu
  Scenario: Closing Sidebar Menu
    Given the user is on the Inventory page with the sidebar menu open
    When the user clicks the "X" button on the sidebar
    Then the sidebar should close
    And the user should remain on the Inventory page

  # 16. Page Refresh Persistence
  Scenario: Page Refresh Persistence
    Given the user is logged in and on the Checkout Step Two page
    When the user refreshes the browser page
    Then the user should remain on the Checkout Step Two page

  # 17. Unauthenticated Direct URL Access
  Scenario: Unauthenticated Direct URL Access
    Given the user is NOT logged in
    When the user attempts to access "https://www.saucedemo.com/inventory.html" directly
    Then the user should be redirected to the login page
    And an error message "Epic sadface: You can only access '/inventory.html' when you are logged in" should be displayed
