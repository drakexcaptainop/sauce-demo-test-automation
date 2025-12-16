

Given('I am logged in to Sauce Demo as {string}') do |username|
  visit('https://www.saucedemo.com/')
  fill_in('user-name', with: username)
  fill_in('password', with: 'secret_sauce')
  click_button('login-button')
end








When('I add {string} to the cart') do |productName|
  product_div = find('.inventory_item', text: productName)
  product_div.click_button('Add to cart')
end


When('I add all items to the cart') do
  all("button.btn_inventory").each do |btn|
    btn.click if btn.text == "Add to cart"
  end
end

When('I remove all items from the cart') do
  all("button.btn_inventory").each do |btn|
    btn.click if btn.text == "Remove"
  end
end

Then('the item number on top of the cart icon should be {string}') do |expected_state|
  if (expected_state == 'hidden')
    expect(page).not_to have_css('span.shopping_cart_badge')
  elsif (expected_state..match(/^\d+$/))
    expect(find('span.shopping_cart_badge').text).to eq(expected_state)
  end
end


When('I go to the shopping cart') do
  find('.shopping_cart_link').click
end

When('I proceed to checkout') do
  click_button('checkout')
end


When('I finish the order') do
  click_button('finish')
end


Then('I see the order success message {string}') do |successMessage|
  expect(page).to have_css('.complete-header', text: successMessage)
end





When('I click the top left Three bar button') do
  find('#react-burger-menu-btn').click
end

When('I click the Logout sidebar button') do
  find('#logout_sidebar_link').click
end

When('I click the shopping cart icon') do
  find('.shopping_cart_link').click
end

Then('I should see the following products and prices on the inventory page:') do |table|
  expected_items = table.raw
  
  product_names = all('.inventory_item_name').map(&:text)
  product_prices = all('.inventory_item_price').map(&:text)
  
  actual_items = product_names.zip(product_prices)
  
  expect(actual_items).to match_array(expected_items)
end

Then('I should see the following products on the inventory page:') do |table|
  expected_products = table.raw.flatten
  actual_products = all('.inventory_item_name').map(&:text)
  expect(actual_products).to match_array(expected_products)
end

Then('the product {string} should display the dog image') do |product_name|
  product = find('.inventory_item', text: product_name)
  img_src = product.find('img.inventory_item_img')[:src]
  expect(img_src).to include('/static/media/sl-404.168b1cce10384b857a6f.jpg')
end

Then('all products should display the dog image') do
  all('img.inventory_item_img').each do |img|
    expect(img[:src]).to include('/static/media/sl-404.168b1cce10384b857a6f.jpg')
  end
end


Given('I am in the Products page') do 
  expect(all('.inventory_item').count).to be > 0
  expect(page).to have_css('span.title', text: 'Products')
end



Then('the cart icon in the top right corner shows the number {string}') do |expected_count|
  expect(find('.shopping_cart_badge')).to have_text(expected_count)
end
## extras


When('I fill the checkout info with:') do |form_data_table|
  first_name = form_data_table.rows_hash['First Name']
  last_name = form_data_table.rows_hash['Last Name']
  zip_code = form_data_table.rows_hash['Zip Code']
  find('#first-name').set(first_name)
  find('[data-test="lastName"]').set(last_name)
  find("#postal-code").set(zip_code)
end


Given('the user is in the Inventory page') do
  visit('/inventory.html')
end

Then('I should still be on the checkout overview page') do
  expect(current_url).to include('checkout-step-two.html')
  expect(page).to have_content('Checkout: Overview')
end

Then('the "Item total" field should show {string}') do |expected_val|
  price_elements = all('.inventory_item_price')
  
  @calculated_sum = price_elements.map { |el| el.text.delete('$').to_f }.sum
  
  expect(@calculated_sum).to eq(expected_val.to_f)

  expect(find('.summary_subtotal_label').text).to include(expected_val)
end

Then('the "Tax" field should show {string}') do |expected_tax|
  calculated_tax = (@calculated_sum * 0.08).round(2)
  
  expect(calculated_tax).to eq(expected_tax.to_f)

  expect(find('.summary_tax_label').text).to include(expected_tax)
end

Then('the "Total" field should show {string}') do |expected_total|
  calculated_total = (@calculated_sum + (@calculated_sum * 0.08).round(2)).round(2)
  
  expect(calculated_total).to eq(expected_total.to_f)

  expect(find('.summary_total_label').text).to include(expected_total)
end




When('I add the following products to the cart: {string}') do |product_list|
  products = product_list.split(',')
  products.each do |product_name|
    clean_name = product_name.strip
    item_container = find('.inventory_item', text: clean_name)
    item_container.find('button', text: 'Add to cart').click
  end
end






Then('I should see the product title {string}') do |product_name|
  page_product_name = find('[data-test="inventory-item-name"]').text
  expect(page_product_name).to eq(product_name)
end

Then('I should see the product description {string}') do |description|
  page_description = find('[data-test="inventory-item-desc"]').text
  expect(page_description).to eq(description)
end

Then('I should see the "Add to cart" button') do
  expect(page).to have_button('Add to cart')
end

When('I click on the name of the product {string}') do |product_name|
  find('.inventory_item_name', text: product_name).click
end


Then('I should be on the product details page') do
  expect(all('.inventory_item_container').count).to eq(1)
  expect(current_url).to include('inventory-item.html')
end
