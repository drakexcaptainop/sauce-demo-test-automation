Feature: As a BDD fanatic
I want to start writing my tests
so I learn more about automation


Scenario Outline: Complete a purchase successfully
Given I am logged in to Sauce Demo as "<user>"
When I add "<item>" to the cart
When I go to the shopping cart
And I proceed to checkout
And I fill the checkout info with "<first_name>", "<last_name>", "<postal_code>"
And I finish the order
Then I see the order success message "<message>"

Examples:
| user                    | item                  | first_name | last_name | postal_code | message                    |
| standard_user           | Sauce Labs Bike Light | Juan       | Perez     | 12345       | Thank you for your order!  |
| performance_glitch_user | Sauce Labs Bike Light | Juan       | Perez     | 12345       | Thank you for your order!  |
| visual_user             | Sauce Labs Bike Light | Juan       | Perez     | 12345       | Thank you for your order!  | 


Scenario Outline: Error in Completing a purchase
Given I am logged in to Sauce Demo as "<user>"
And I add "<item>" to the cart
When I go to the shopping cart
And I proceed to checkout
And I fill the checkout info with "<first_name>", "<last_name>", "<postal_code>"
Then I see an error message "<message>"

Examples:
| user         | item                  | first_name | last_name | postal_code | message                           |
| problem_user | Sauce Labs Bike Light | Juan       |           | 12345       | Error: Last Name is required      |


Scenario: Finish button does not work for error_user
  Given I am logged in to Sauce Demo as "error_user"
  When I add "Sauce Labs Bike Light" to the cart
  And I go to the shopping cart
  And I proceed to checkout
  And I fill the checkout info with "Juan", "Perez", "12345"
  And I finish the order
  Then I should still be on the checkout overview page

Scenario Outline: Add items to the cart depending on user type
  Given I am logged in to Sauce Demo as "<user>"
  When I add all items to the cart
  Then the cart badge shows "<expected_count>"

Examples:
| user                    | expected_count |
| standard_user           | 6              |
| performance_glitch_user | 6              |
| visual_user             | 6              |
| problem_user            | 3              |
| error_user              | 3              |

Scenario Outline: Remove all items depending on user type
  Given I am logged in to Sauce Demo as "<user>"
  When I add all items to the cart
  And I remove all items from the cart
  Then <expected_result>

Examples:
| user                    | expected_result                 |
| standard_user           | the cart badge is not visible   |
| performance_glitch_user | the cart badge is not visible   |
| visual_user             | the cart badge is not visible   |
| problem_user            | the cart badge stays at "3"     |
| error_user              | the cart badge stays at "3"     |
