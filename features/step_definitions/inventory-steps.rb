
$login_page = LoginPage.instance
$inventory_page = InventoryPage.instance


Given('I am logged in to Sauce Demo as {string}') do |username|
  $login_page.visit_page
  $login_page.fill_credentials(username, 'secret_sauce')
  $login_page.submit
end

When('I add {string} to the cart') do |productName|
  $inventory_page.click_product_button(productName, InventoryPage::ADD_TO_CART_BTN)
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
    expect(page).not_to have_css(InventoryPage::CLASS_SHOPPING_CART_BADGE)
  elsif (expected_state..match(/^\d+$/))
    expect($inventory_page.get_shopping_cart_badge_count_as_str).to eq(expected_state)
  end
end


When('I go to the shopping cart') do
  $inventory_page.click_shopping_cart_link
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
  $inventory_page.click_burger_menu_btn
end

When('I click the Logout sidebar button') do
  $inventory_page.click_logout_sidebar_link
end

When('I click the shopping cart icon') do
  $inventory_page.click_shopping_cart_link
end

Then('I should see the following products and prices on the inventory page:') do |table|
  expected_items = table.raw
  actual_items = $inventory_page.get_all_products_name_price_pairs
  expect(actual_items).to match_array(expected_items)
end

Then('I should see the following products on the inventory page:') do |table|
  expected_products = table.raw.flatten
  actual_products = $inventory_page.get_all_product_names
  expect(actual_products).to match_array(expected_products)
end

Then('the product {string} should display the dog image') do |product_name|
  img_src = $inventory_page.get_product_img_src(product_name)
  hexhash = ImageDataComparer.new.image_hex_hash_from_url(img_src)
  expect(ENV['image_hash']).to eq( hexhash )
end

Then('all products should display the dog image') do
  img_sources =  $inventory_page.get_all_products_img_srcs
  unique_sources = img_sources.uniq
  expect(unique_sources.size).to eq(1)
  hexhash = ImageDataComparer.new.image_hex_hash_from_url(unique_sources[0])
  expect(ENV['image_hash']).to eq( hexhash )
end


Given('I am in the Products page') do 
  expect($inventory_page.get_product_count).to be > 0
  expect(page).to have_css(InventoryPage::CLASS_TITLE, text: 'Products')
end

Then('the cart icon in the top right corner shows the number {string}') do |expected_count|
  expect($inventory_page.get_shopping_cart_badge_count_as_str).to eq(expected_count)
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
  $inventory_page.click_product_name(product_name)
end


Then('I should be on the product details page') do
  expect(all('.inventory_item_container').count).to eq(1)
  expect(current_url).to include('inventory-item.html')
end
