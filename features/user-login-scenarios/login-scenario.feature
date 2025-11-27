Feature: User Login
  Scenario Outline: Login validation with different user credentials
    Given I am on the login page
    When I input username "<username>" and password "<password>"
    And I click the login button
    Then I should be redirected to "<expected_result>"

    Examples:
      | username        | password     | expected_result |
      | standard_user   | secret_sauce | inventory       |
      | problem_user    | secret_sauce | inventory       |
      | locked_out_user | secret_sauce | error_message   |
      | invalid_user    | wrong_pass   | error_message   |
      | visual_user    | secret_sauce   | inventory  |
      | performance_glitch_user | secret_sauce | inventory_item |