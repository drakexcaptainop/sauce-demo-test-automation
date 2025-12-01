#jorge
When('I click "Add to cart" for the product {string}') do |product_name|
  @inventory_page = InventoryPage.new
  @inventory_page.add_product_to_cart(product_name)
end

Then('the shopping cart badge should show {string}') do |count|
  expect(@inventory_page.get_cart_count).to eq(count)
end

Then('the button for {string} should change to {string}') do |product_name, expected_text|
  result = @inventory_page.check_button_state(product_name, expected_text)
  expect(result).to be true
end

#natha
Given('I browse to Sauce Demo main page') do
  visit('https://www.saucedemo.com/')
end

Given('I am logged in to Sauce Demo as {string}') do |username|
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: username)
  fill_in('password', with: 'secret_sauce')
  click_button('login-button')
end

When('I enter {string} as username') do |username|
  fill_in('user-name', with: username)

end

When('I type {string} as password') do |password|
  fill_in('password', with: password)
  click_button('login-button')
end

Then('I see the Sauce Demo page displayed') do
  expect(page).to have_content('Products')
  expect(page).to have_css('.inventory_list')
end


When('I add {string} to the cart') do |productName|
  product_div = find('.inventory_item', text: productName)
  product_div.click_button('Add to cart')
end


When('I add all items to the cart') do
  all("button.btn_inventory").each do |btn|
    btn.click
  end
end

When('I remove all items from the cart') do
  all("button.btn_inventory").each do |btn|
    btn.click if btn.text == "Remove"
  end
end



Then('the cart badge is not visible') do
  expect(page).not_to have_css('.shopping_cart_badge')
end

Then('the cart badge stays at {string}') do |count|
  expect(page).to have_css('.shopping_cart_badge', text: count)
end

Then('the cart badge shows {string}') do |count|
  expect(page).to have_css('.shopping_cart_badge', text: count)
end


When('I go to the shopping cart') do
  find('.shopping_cart_link').click
end

When('I proceed to checkout') do
  click_button('checkout')
end

When('I fill the checkout info with {string}, {string}, {string}') do |first, last, zip|
  fill_in('first-name', with: first)
  fill_in('last-name', with: last)
  fill_in('postal-code', with: zip)
  click_button('continue')
end

When('I finish the order') do
  click_button('finish')
end


Then('I see the order success message {string}') do |successMessage|
  expect(page).to have_css('.complete-header', text: successMessage)
end

Then('I see an error message {string}') do |errorMessage|
  expect(page).to have_css('.error-message-container.error', text: errorMessage)
end

Then('I should still be on the checkout overview page') do
  expect(page).to have_current_path(/checkout-step-two\.html/)
end
 