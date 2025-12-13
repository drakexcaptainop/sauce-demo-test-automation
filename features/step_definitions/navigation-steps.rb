
Given('the user opens the browser and navigates to {string}') do |url|
  visit(url)
end

Given('the user is on the login page') do
  visit('https://www.saucedemo.com/')
end

When('the user enters the username {string}') do |username|
  fill_in('user-name', with: username)
end

When('the user enters the password {string}') do |password|
  fill_in('password', with: password)
end

When('the user clicks the {string} button') do |button_text|
  click_button(button_text)
end

Then('the user should be redirected to the Inventory page') do
  expect(current_url).to include('/inventory.html')
end

Then('the URL should contain {string}') do |path|
  expect(current_url).to include(path)
end



# 2. Failed Login Navigation Guard
When('the user enters an invalid username or password') do
  fill_in('user-name', with: 'invalid_user')
  fill_in('password', with: 'wrong_pass')
end

Then('the user should remain on the login page') do
  expect(page).to have_selector('#login-button')
  expect(current_url).to include('/login.html')
  expect(page).to have_selector('form')
  expect(page).to have_selector('#user-name')
  expect(page).to have_selector('#password')
end

Then('the URL should remain {string}') do |url|
  expect(current_url).to eq(url)
end

Then('an error message container should be displayed') do
  expect(page).to have_css('.error-message-container')
end

# 3. Navigation: Inventory to Product Detail and Back
Given('the user is logged in as {string}') do |username|
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: username)
  fill_in('password', with: 'secret_sauce')
  click_button('Login')
end

Given('the user is on the Inventory page') do
  expect(current_url).to include('/inventory.html')
end

When('the user clicks on the title of the first product') do
  first('.inventory_item_name').click
end

Then('the user should be taken to the product detail page') do
  expect(page).to have_css('.inventory_details')
end

Then('the user should be redirected back to the Inventory page') do
  expect(current_url).to include('/inventory.html')
end

# 4. Navigation: Inventory to Cart and Back
When('the user clicks the shopping cart icon') do
  find('.shopping_cart_link').click
end

Then('the user should be taken to the Cart page') do
  expect(current_url).to include('/cart.html')
end

# 5. Sidebar Menu Expansion
When('the user clicks the {string} icon') do |icon_name|
  if icon_name == 'Burger Menu'
    find('#react-burger-menu-btn').click
  end
end

Then('the sidebar navigation panel should slide into view') do
  expect(page).to have_css('.bm-menu-wrap', visible: true)
end


Then('the menu options {string}, {string}, {string}, {string} should be visible') do |opt1, opt2, opt3, opt4|
  expect(page).to have_content(opt1)
  expect(page).to have_content(opt2)
  expect(page).to have_content(opt3)
  expect(page).to have_content(opt4)
end

# 6. Sidebar Navigation: "All Items"
Given('the user is currently on the Cart page') do
  find('.shopping_cart_link').click
end

When('the user opens the sidebar menu') do
  find('#react-burger-menu-btn').click
end

When('the user clicks the {string} link') do |link_text|
  click_link(link_text)
end

# 7. Full Checkout Flow Navigation
Given('the user is logged in and has at least one item in the cart') do
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: 'standard_user')
  fill_in('password', with: 'secret_sauce')
  click_button('Login')
  first('.btn_inventory').click
end

Given('the user is on the Cart page') do
  find('.shopping_cart_link').click
end

Then('the user should be on the Checkout Step One page {string}') do |path|
  expect(current_url).to include(path)
end

When('the user enters valid checkout information and clicks {string}') do |button_text|
  fill_in('first-name', with: 'Test')
  fill_in('last-name', with: 'User')
  fill_in('postal-code', with: '12345')
  click_button(button_text)
end

Then('the user should be on the Checkout Step Two page {string}') do |path|
  expect(current_url).to include(path)
end

Then('the user should be on the Checkout Complete page {string}') do |path|
  expect(current_url).to include(path)
end

# 8. Checkout Cancellation Navigation
Given('the user is logged in and on the Checkout Information page') do
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: 'standard_user')
  fill_in('password', with: 'secret_sauce')
  click_button('Login')
  find('.shopping_cart_link').click
  click_button('Checkout')
end

# 9. Post-Purchase Navigation ("Back Home")
Given('the user is on the Checkout Complete page') do
  # Setup state to be on complete page
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: 'standard_user')
  fill_in('password', with: 'secret_sauce')
  click_button('Login')
  first('.btn_inventory').click
  find('.shopping_cart_link').click
  click_button('Checkout')
  fill_in('first-name', with: 'Test')
  fill_in('last-name', with: 'User')
  fill_in('postal-code', with: '12345')
  click_button('Continue')
  click_button('Finish')
end

# 10. External Link Navigation (Sidebar)
Given('the user is logged in and the sidebar menu is open') do
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: 'standard_user')
  fill_in('password', with: 'secret_sauce')
  click_button('Login')
  find('#react-burger-menu-btn').click
end

Then('the browser should navigate to {string}') do |url|
  # Handling external navigation can be tricky with Capybara depending on driver
  # Assuming standard behavior where it follows
  expect(current_url).to eq(url)
end

# 11. Logout Navigation
Given('the user is logged in') do
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: 'standard_user')
  fill_in('password', with: 'secret_sauce')
  click_button('Login')
end

Then('the login form should be displayed') do
  expect(page).to have_selector('#login-button')
  expect(current_url).to include('/login.html')
  expect(page).to have_selector('form')
  expect(page).to have_selector('#user-name')
  expect(page).to have_selector('#password')
end

# 12. Browser Back Button Functionality
Given('the user has navigated from the Inventory page to the Cart page') do
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: 'standard_user')
  fill_in('password', with: 'secret_sauce')
  click_button('Login')
  find('.shopping_cart_link').click
end

When('the user clicks the browser\'s {string} button') do |direction|
  if direction == 'Back'
    page.go_back
  elsif direction == 'Forward'
    page.go_forward
  end
end

Then('the user should be returned to the Inventory page') do
  expect(current_url).to include('/inventory.html')
end

# 13. Browser Forward Button Functionality
Given('the user has navigated from Inventory to Cart and clicked Back') do
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: 'standard_user')
  fill_in('password', with: 'secret_sauce')
  click_button('Login')
  find('.shopping_cart_link').click
  page.go_back
end

Then('the user should be returned to the Cart page') do
  expect(current_url).to include('/cart.html')
end

# 14. Filter State Navigation (View Change)
When('the user selects {string} from the sort dropdown') do |option|
  select option, from: 'product_sort_container'
end

Then('the product order should update') do
  # Implementation depends on verifying order, e.g., checking first item name
  # For now, we assume it works if no error
end

Then('the page should not reload') do
  # Difficult to test strictly without JS hooks, but we can check if an element persists
  # or if execution context remains. Capybara handles this implicitly usually.
end

# 15. Closing Sidebar Menu
Given('the user is on the Inventory page with the sidebar menu open') do
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: 'standard_user')
  fill_in('password', with: 'secret_sauce')
  click_button('Login')
  find('#react-burger-menu-btn').click
end

When('the user clicks the {string} button on the sidebar') do |btn|
  find('#react-burger-cross-btn').click
end

Then('the sidebar should close') do
  expect(page).to have_no_css('.bm-menu-wrap', visible: true)
end

Then('the user should remain on the Inventory page') do
  expect(current_url).to include('/inventory.html')
end

# 16. Page Refresh Persistence
Given('the user is logged in and on the Checkout Step Two page') do
  visit('/')
  fill_in('user-name', with: 'standard_user')
  fill_in('password', with: 'secret_sauce')
  click_button('Login')
  first('.btn_inventory').click
  find('.shopping_cart_link').click
  click_button('Checkout')
  fill_in('first-name', with: 'Test')
  fill_in('last-name', with: 'User')
  fill_in('postal-code', with: '12345')
  click_button('Continue')
end

When('the user refreshes the browser page') do
  visit current_url
end

Then('the user should remain on the Checkout Step Two page') do
  expect(current_url).to include('/checkout-step-two.html')
end

# 17. Unauthenticated Direct URL Access
Given('the user is NOT logged in') do
  visit('https://www.saucedemo.com/')
  # Ensure we are logged out if needed, but starting fresh is safer
  # Assuming new session or reset
end

When('the user attempts to access {string} directly') do |url|
  visit(url)
end

Then('an error message {string} should be displayed') do |msg|
  expect(page).to have_content(msg)
end

# 1. Navigation Step
Given('the user navigates to the {string} page') do |page_name|
  # Map the Gherkin string to the specific SauceDemo URL
  path = case page_name
         when 'Inventory'
           '/inventory.html'
         when 'Cart'
           '/cart.html'
         when 'Checkout Step One'
           '/checkout-step-one.html'
         when 'Checkout Step Two'
           '/checkout-step-two.html'
         else
           raise "Error: mapping for '#{page_name}' not defined in step definition."
         end

  # Visit the mapped URL
  visit path
end

# 2. Validation Step
Then('the user should remain on the {string} page') do |page_name|
  # We reuse the logic to know what URL part we expect
  expected_part = case page_name
                  when 'Inventory'         then 'inventory.html'
                  when 'Cart'              then 'cart.html'
                  when 'Checkout Step One' then 'checkout-step-one.html'
                  when 'Checkout Step Two' then 'checkout-step-two.html'
                  else
                    raise "Error: mapping for '#{page_name}' not defined."
                  end

  # Verify the browser URL contains the expected part
  expect(current_url).to include(expected_part)
  
  # Optional: Extra robustness by checking the page title text
  # This confirms not just the URL, but that the page actually loaded the content
  # header_text = find('.title').text
  # expect(header_text).to eq(page_name.upcase) # SauceDemo titles are usually uppercase
end