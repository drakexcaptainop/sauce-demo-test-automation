
$login_page = LoginPage.instance
$inventory_page = InventoryPage.instance
$product_details_page = ProductDetailsPage.instance




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
  $checkout_your_info_page.fill_in_form(first_name, last_name, zip_code)
end


Given('the user is in the Inventory page') do
  $inventory_page.visit_page
  expect($inventory_page.get_title_text).to eq('Products')
  expect(page).to have_selector(InventoryPage::ID_INVENTORY_CONTAINER)
  expect($inventory_page.get_product_count).to be > 0
end

Then('I should still be on the checkout overview page') do
  expect(current_url).to include(CheckoutOverviewPage::URL)
  expect(page).to have_content('Checkout: Overview')
  expect(page).to have_button('Finish')
  expect(page).to have_button('Cancel')
  expect(page).to have_selector(CheckoutOverviewPage::CLASS_INVENTORY_ITEM)
  expect(page).to have_selector(CheckoutOverviewPage::CLASS_SUBTOTAL)
  expect(page).to have_selector(CheckoutOverviewPage::CLASS_TAX)
  expect(page).to have_selector(CheckoutOverviewPage::CLASS_TOTAL)
end





Then('I should see the product title {string}') do |product_name|
  page_product_name = $product_details_page.get_product_name
  expect(page_product_name).to eq(product_name)
end

Then('I should see the product description {string}') do |description|
  page_description = $product_details_page.get_product_description
  expect(page_description).to eq(description)
end

Given('the user is logged in to Sauce Demo as {string}') do |username|
  $login_page.visit_page
  $login_page.fill_credentials(username, 'secret_sauce')
  $login_page.submit
end

Then('I should see the "Add to cart" button') do
  expect(page).to have_selector(ProductDetailsPage::DATA_TEST_ADD_TO_CART_BTN)
end

When('I click on the name of the product {string}') do |product_name|
  $inventory_page.click_product_name(product_name)
end


Then('I should be on the product details page') do
  expect(page).to have_selector(ProductDetailsPage::DATA_TEST_ADD_TO_CART_BTN)
  expect(page).to have_selector(ProductDetailsPage::DATA_TEST_INVENTORY_ITEM_NAME)
  expect(page).to have_selector(ProductDetailsPage::DATA_TEST_INVENTORY_ITEM_PRICE)
  expect(page).to have_selector(ProductDetailsPage::DATA_TEST_INVETORY_ITEM_DESCRIPTION)
  expect(page).to have_selector(ProductDetailsPage::ID_BACK_TO_PRODUCTS_BTN)
end
