

Given('I am on the login page') do
  @login_page = LoginPage.new 
  @login_page.visit_page

end

When('I input username {string} and password {string}') do |user, pass|
  @login_page.fill_credentials(user, pass)
end

When('I click the login button') do
  @login_page.submit
end


Then('I should be redirected to {string}') do |expected_result|
  result = @login_page.check_login_status(expected_result)
  expect(result).to be true
end

Then('I should see the inventory page') do
  result = @login_page.check_login_status('inventory')
  expect(result).to be true
end

Then('I should see the inventory item page') do
  result = @login_page.check_login_status('inventory_item')
  expect(result).to be true
end

Then('I should see an error message') do
  result = @login_page.check_login_status('error_message')
  expect(result).to be true
end

Then('I should see the inventory page with the following products:') do |table|
  inventory_items = @login_page.get_inventory_items
  scenario_items = table.raw.flatten
  scenario_items.each do |item|
    expect( inventory_items.any? { |inventory_item| inventory_item == item } ).to be(true)
  end
end


Then('all product images on the page should be identical') do
  image_sources = @login_page.get_inventory_images
  unique_images = image_sources.uniq
  expect(unique_images.length).to eq(1)
end


Then('I should see the {string} item page') do |string|
  sleep 10
end