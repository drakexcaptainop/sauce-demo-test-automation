When('I click Continue') do
  find('#continue').click
end

Then('I should see the {string} page') do |string|
  expect(page).to have_content(string)
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