
Given('I am logged in as {string}') do |string|
  @login_page = LoginPage.new 
  @login_page.visit_page
  @login_page.fill_credentials(string, 'secret_sauce')
  @login_page.submit
end

When('I add the products {string} to the cart') do |products_string|
  @inventory_page = InventoryPage.new
  products = products_string.split(',').map(&:strip)
  products.each do |product|
    @inventory_page.add_product_to_cart(product)
  end
end

Then('the cart icon should display {string}') do |cart_count|
  expect(@inventory_page.get_cart_count).to eq(cart_count)
end

Then('the buttons for {string} should say {string}') do |products_string, expected_text|
  products = products_string.split(',').map(&:strip)
  products.each do |product_name| 
    expect(@inventory_page.check_button_state(product_name, expected_text)).to be true
  end
end

When('I open the left sidebar menu and click {string}') do |button_text|
    if(@inventory_page.nil?)
        @inventory_page = InventoryPage.new
    end
    @inventory_page.open_left_sidebar_menu
    @inventory_page.click_sidebar_button(button_text)
end

Then('the shopping cart icon should display no count') do
  expect(@inventory_page.get_cart_count).to eq('0')
end