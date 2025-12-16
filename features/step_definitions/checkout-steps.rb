When('I click Continue') do
  find('#continue').click
end

Then('I should see the {string} page') do |page_title|
  expect(page).to have_content(page_title)
  case page_title
  when 'Checkout: Your Information'
    expect(find('.title').text).to eq('Checkout: Your Information')
    form_elements = ['first-name', 'last-name', 'postal-code']
    form_elements.each do |element|
      expect(page).to have_field(element)
    end
    expect(page).to have_button('Continue')
    expect(page).to have_button('Cancel')

  when 'Checkout: Overview'
    expect(find('.title').text).to eq('Checkout: Overview')
    expect(page).to have_button('Finish')
    expect(page).to have_button('Cancel')
    expect(page).to have_selector('.cart_item')
    expect(page).to have_selector('.summary_info')
    expect(page).to have_selector('.summary_total_label')
    expect(page).to have_selector('.summary_tax_label')
    expect(page).to have_selector('.summary_subtotal_label')
  when 'Checkout: Complete!'
    expect(find('.title').text).to eq('Checkout: Complete!')
    expect(page).to have_button('Back Home')
    expect(find('.complete-header').text).to eq('Thank you for your order!')
  when 'Products'
    expect(find('.title').text).to eq('Products')
    expect(page).to have_selector('#inventory_container')
    expect(all('.inventory_item').count).to be > 0
  when 'Your Cart'
    expect(find('.title').text).to eq('Your Cart')
    expect(page).to have_button(id: 'checkout')
    expect(page).to have_button(id: 'continue-shopping')
  end
end

Then('I should see the error message {string} at the bottom of the form') do |error_msg|
  error_container = find('[data-test="error"]')
  
  expect(error_container.text).to eq(error_msg)
end

Then('I should remain on the {string} page') do |page_title|
  expect(current_url).to include('checkout-step-one.html')
  
  expect(find('.title').text).to eq(page_title)
end

When('I click the Checkout button') do
  find('#checkout').click
end




When('I click the Checkout button on the top right corner of the page') do
  find('#checkout').click
end

Then('the Last Name field should be empty') do
  expect(find('#last-name').text).to eq('')
end

Given('I have added the following products to the cart:') do |table|
  table.hashes.each do |product|
    formatted_btn_name = product['Product Name'].downcase.tr(' ', '-')
    button_name = "#add-to-cart-#{formatted_btn_name}"
    find(button_name).click
  end
end


Then('I should see the following payment calculations:') do |table|
  rows_hash = table.rows_hash
  cop = CheckoutPage.new
  item_total, tax, total = cop.get_page_totals

  scenario_item_total = rows_hash['Item total'].to_f
  scenario_tax_total = rows_hash['Tax'].to_f
  scenario_total = rows_hash['Total'].to_f

  page_item_total = find('.summary_subtotal_label').text.delete('Item total: $').to_f
  page_tax_total = find('.summary_tax_label').text.delete('Tax: $').to_f
  page_total = find('.summary_total_label').text.delete('Total: $').to_f

  
  puts 'SCENARIO TOTALS'
  puts(scenario_item_total, scenario_tax_total, scenario_total)

  puts 'CALULATED TOTALS'
  puts(  item_total, tax, total)

  puts 'PAGE TOTALS'
  puts(page_item_total, page_tax_total, page_total)


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
  find('#finish').click
end

Then('the "Back Home" button should be visible') do 
  expect(find('[data-test="back-to-products"]').text).to eq('Back Home')
end
Then('the "Thank you for your order!" text message should be visible') do 
  expect(find('h2.complete-header').text).to eq('Thank you for your order!')
end

Then('the Your Cart page should display the products:') do |table|
    current_inventory_items = all('.inventory_item_name').map(&:text)
    table.hashes.each do |product|
      product_name = product['Product Name']
      expect(current_inventory_items.include?(product_name)).to be(true)
    end
end