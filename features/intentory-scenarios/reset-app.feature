Feature: Reset App

Scenario Outline: Reset App clears data
    Given I am logged in as "standard_user"
    
    When I add the products "<products>" to the cart
    Then the cart icon should display "<count>"
    And the buttons for "<products>" should say "Remove"
    
    When I open the left sidebar menu and click "Reset App State"
    
    Then the shopping cart icon should display no count
    And the buttons for "<products>" should say "Remove"

    Examples:
      | products                                   | count |
      | Sauce Labs Backpack, Sauce Labs Bike Light | 2     |