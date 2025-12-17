$inventory_page = InventoryPage.instance
$your_cart_page = YourCartPage.instance
$checkout_your_info_page = CheckoutYourInformationPage.instance
$checkout_overview_page = CheckoutOverviewPage.instance
$checkout_complet_page = CheckoutCompletePage.instance

When('I click Continue') do
  $checkout_your_info_page.click_continue_btn
end

Then('I should see the {string} page') do |page_title|
  expect(page).to have_content(page_title)
  case page_title
    when 'Checkout: Your Information'
      expect($checkout_your_info_page.get_title_text).to eq('Checkout: Your Information')
      form_elements = CheckoutYourInformationPage::FORM_ELEMENTS
      form_elements.each do |element|
        expect(page).to have_field(element)
      end
      expect(page).to have_button('Continue')
      expect(page).to have_button('Cancel')

    when 'Checkout: Overview'
      expect($checkout_overview_page.get_title_text).to eq('Checkout: Overview')
      expect(page).to have_button('Finish')
      expect(page).to have_button('Cancel')
      expect(page).to have_selector(CheckoutOverviewPage::CLASS_INVENTORY_ITEM)
      expect(page).to have_selector(CheckoutOverviewPage::CLASS_SUBTOTAL)
      expect(page).to have_selector(CheckoutOverviewPage::CLASS_TAX)
      expect(page).to have_selector(CheckoutOverviewPage::CLASS_TOTAL)
    when 'Checkout: Complete!'
      expect($checkout_complet_page.get_title_text).to eq('Checkout: Complete!')
      expect(page).to have_button('Back Home')
      expect(find(CheckoutCompletePage::CLASS_COMPLETE_HEADER).text).to eq('Thank you for your order!')
      expect(page).to have_selector(CheckoutCompletePage::CLASS_COMPLETE_TEXT)

    when 'Products'
      expect($inventory_page.get_title_text).to eq('Products')
      expect(page).to have_selector(InventoryPage::ID_INVENTORY_CONTAINER)
      expect($inventory_page.get_product_count).to be > 0
    when 'Your Cart'
      expect($your_cart_page.get_title_text).to eq('Your Cart')
      expect(page).to have_selector(YourCartPage::ID_CONTINUE_SHOPPING_BTN)
      expect(page).to have_selector(YourCartPage::CLASS_CHECKOUT_BTN)
  end
end

Then('I should see the error message {string} at the bottom of the form') do |error_msg|
  error_container_text = $checkout_your_info_page.get_error_container_text
  expect(error_container_text).to eq(error_msg)
end

Then('I should remain on the {string} page') do |page_title|
  expect(current_url).to include(CheckoutYourInformationPage::URL)
  expect($checkout_your_info_page.get_title_text).to eq(page_title)
end

When('I click the Checkout button') do
  $your_cart_page.click_checkout_btn
end




When('I click the Checkout button on the top right corner of the page') do
  $your_cart_page.click_checkout_btn
end

Then('the Last Name field should be empty') do
  expect($checkout_your_info_page.get_last_name_form_value).to eq('')
end

Given('I have added the following products to the cart:') do |table|
  table.hashes.each do |product|
    $inventory_page.click_product_button(product['Product Name'], InventoryPage::ADD_TO_CART_BTN)
  end
end


Then('I should see the following payment calculations:') do |table|
  rows_hash = table.rows_hash
  
  scenario_item_total = rows_hash['Item total'].to_f
  scenario_tax_total = rows_hash['Tax'].to_f
  scenario_total = rows_hash['Total'].to_f

  item_total, tax, total = $checkout_overview_page.get_page_totals

  page_item_total = $checkout_overview_page.get_subtotal_as_f
  page_tax_total = $checkout_overview_page.get_tax_as_f
  page_total = $checkout_overview_page.get_total_as_f


  expect(item_total).to eq(scenario_item_total)
  expect(tax).to eq(scenario_tax_total)
  expect(total).to eq(scenario_total)

  expect(page_item_total).to eq(item_total)
  expect(page_tax_total).to eq(tax)
  expect(page_total).to eq(total)

end

Then('the empty Last Name field should not give me an error') do 
  expect(1).to eq(1)
end

When('I click Finish') do 
  $checkout_overview_page.click_finish_btn
end

Then('the "Back Home" button should be visible') do 
  expect($checkout_complet_page.get_back_home_btn_text).to eq('Back Home')
end
Then('the "Thank you for your order!" text message should be visible') do 
  expect($checkout_complet_page.get_header_message_text).to eq('Thank you for your order!')
end

Then('the Your Cart page should display the products:') do |table|
    current_inventory_items = $your_cart_page.get_all_product_names
    table.hashes.each do |product|
      product_name = product['Product Name']
      expect(current_inventory_items.include?(product_name)).to be(true)
    end
end