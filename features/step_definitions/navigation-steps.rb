


When('the user clicks the {string} button') do |button_text|
  click_button(button_text)
end

Then('the user should be redirected to the Inventory page') do
  expect(current_url).to include('/inventory.html')
end

Then('the URL should contain {string}') do |path|
  expect(current_url).to include(path)
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



When('the user opens the sidebar menu') do
  find('#react-burger-menu-btn').click
end

When('the user clicks the {string} link') do |link_text|
  click_link(link_text)
end


Then('the browser should navigate to the Sauce Labs page') do
  expect(current_url).to eq('https://saucelabs.com/')
end


When('the user refreshes the browser page') do
  visit current_url
end





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
end


Given('I have opened the details for {string}') do |product_name|
  expect(current_url).to include('/inventory.html')
  find('.inventory_item_name ', text: product_name).click
end


When('I click the "Back to products" button') do 
  expect(current_url).to include('/inventory-item.html')
  find('#back-to-products').click
end

Then('I should see the "Checkout" button') do 
  expect(current_url).to include('/cart.html')
  expect(page).to have_button(id: 'checkout')
end

Given('I am on the "Your Cart" page') do
  visit('/cart.html')
end

When('I click the "Continue Shopping" button') do
  find('#continue-shopping').click
end

