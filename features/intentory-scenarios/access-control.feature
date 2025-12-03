Feature: Security Access Control
@control
  Scenario Outline: Attempt to access protected pages without authentication
    Given I am not logged in
    When I attempt to navigate directly to the "<page_name>" at www.saucedemo.com/"<url_extension>"
    Then I should be redirected to the Login Page
    And I should see the error: Epic sadface: You can only access /"<url_extension>" when you are logged in.

    Examples:
      | page_name | url_extension       |
      | Inventory | inventory.html     |
      | Cart      | cart.html          |
      | Checkout  | checkout-step-one.html |