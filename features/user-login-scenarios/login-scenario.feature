Feature: User Login

  Scenario Outline: Login failure validation
    Given I am on the login page
    When I input username "<username>" and password "<password>"
    And I click the login button
    Then I should see an error message

    Examples:
      | username        | password     |
      | locked_out_user | secret_sauce |
      | invalid_user    | wrong_pass   |

@standard_user
  Scenario: Login successfully as standard user
    Given I am on the login page
    And I input username "<username>" and password "<password>"
    And I click the login button
    Then I should see the inventory page with the following products:
      | Sauce Labs Backpack               |
      | Sauce Labs Bike Light             |
      | Sauce Labs Bolt T-Shirt           |
      | Sauce Labs Fleece Jacket          |
      | Sauce Labs Onesie                 |
      | Test.allTheThings() T-Shirt (Red) |
  Examples:
      | username        | password     |
      | standard_user | secret_sauce |
      | error_user    | secret_sauce   |
      | performance_glitch_user    | secret_sauce   |

@problem_user
  Scenario: Problem User sees duplicated images
    Given I am on the login page
    And I input username "problem_user" and password "secret_sauce"
    And I click the login button
    Then all product images on the page should be identical

@visual_user
  Scenario: Login successfully as visual user
    Given I am on the login page
    When I input username "visual_user" and password "secret_sauce"
    And I click the login button
    Then I should see the inventory page