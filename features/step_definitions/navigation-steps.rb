


When('the user clicks the {string} button') do |button_text|
  click_button(button_text)
  # gen? cambiar
end

Then('the user should be redirected to the Inventory page') do
  expect(current_url).to include(InventoryPage::URL)
end

Then('the URL should contain {string}') do |path|
  expect(current_url).to include(path)
end


When('the user clicks on the title of the first product') do
  InventoryPage.instance.click_product_name('Sauce Labs Backpack')
end



When('the user clicks the shopping cart icon') do
  InventoryPage.instance.click_shopping_cart_link
end


When('the user clicks the {string} icon') do |icon_name|
  if icon_name == 'Burger Menu'
    InventoryPage.instance.click_burger_menu_btn
  end
end

Then('the sidebar navigation panel should slide into view') do
  expect(page).to have_css(InventoryPage::CLASS_SIDE_MENU, visible: true)
end


Then('the followin menu options should be visible:') do |option_table|
  option_table.hashes.each do |option|
    option_name = option['Option Name']
    expect(page).to have_selector(InventoryPage::CLASS_SIDE_BAR_MENU_ITEM, text: option_name)
  end
end



When('the user opens the sidebar menu') do
  InventoryPage.instance.click_burger_menu_btn
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
  case page_name
    when 'Inventory'
      InventoryPage.instance.visit_page
    when 'Cart'
      YourCartPage.instance.visit_page
    when 'Checkout Step One'
      CheckoutYourInformationPage.instance.visit_page
    when 'Checkout Step Two'
      CheckoutOverviewPage.instance.visit_page
    when 'Checkout Complete'
      CheckoutCompletePage.instance.visit_page
  end
end

Then('the user should remain on the {string} page') do |page_name|
  expected_part = case page_name
                  when 'Inventory'         then InventoryPage::URL
                  when 'Cart'              then YourCartPage::URL
                  when 'Checkout Step One' then CheckoutYourInformationPage::URL
                  when 'Checkout Step Two' then CheckoutOverviewPage::URL
                  when 'Checkout Complete' then CheckoutCompletePage::URL
                  else
                    raise "Error: mapping for '#{page_name}' not defined."
                  end

  expect(current_url).to include(expected_part)
end


Given('I have opened the details for {string}') do |product_name|
  expect(current_url).to include(InventoryPage::URL)
  InventoryPage.instance.click_product_name(product_name)
end


When('I click the "Back to products" button') do 
  expect(current_url).to include(ProductDetailsPage::URL)
  ProductDetailsPage.instance.click_back_to_products_btn
end

Then('I should see the "Checkout" button') do 
  expect(current_url).to include(YourCartPage::URL)
  expect(page).to have_selector(YourCartPage::CLASS_CHECKOUT_BTN)
end

Given('I am on the "Your Cart" page') do
  YourCartPage.instance.visit_page
end

When('I click the "Continue Shopping" button') do
  YourCartPage.instance.click_continue_shopping_btn
end

