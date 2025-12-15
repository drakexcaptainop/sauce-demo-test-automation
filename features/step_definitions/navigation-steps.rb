


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


# 3. Navigation: Inventory to Product Detail and Back


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


When('the user opens the sidebar menu') do
  find('#react-burger-menu-btn').click
end

When('the user clicks the {string} link') do |link_text|
  click_link(link_text)
end

# 7. Full Checkout Flow Navigation


# 8. Checkout Cancellation Navigation


# 9. Post-Purchase Navigation ("Back Home")


# 10. External Link Navigation (Sidebar)


Then('the browser should navigate to {string}') do |url|
  # Handling external navigation can be tricky with Capybara depending on driver
  # Assuming standard behavior where it follows
  expect(current_url).to eq(url)
end

# 11. Logout Navigation


# 12. Browser Back Button Functionality


# 14. Filter State Navigation (View Change)


# 15. Closing Sidebar Menu


# 16. Page Refresh Persistence


When('the user refreshes the browser page') do
  visit current_url
end



# 17. Unauthenticated Direct URL Access


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