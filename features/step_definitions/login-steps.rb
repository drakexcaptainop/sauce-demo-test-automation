
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




Given('I am logged in as {string}') do |username|
  @login_page = LoginPage.new
  @login_page.visit_page
  @login_page.fill_credentials(username, 'secret_sauce')
  @login_page.submit
end

Then('the Login button should be visible') do
  expect(page).to have_selector('#login-button')
end

Then('the Username and Password fields should be empty') do
  expect(find('#user-name').value).to be_empty
  expect(find('#password').value).to be_empty
end

Then('I should see the error message {string}') do |expected_message|
  expect(@login_page.get_error_message).to include(expected_message)
end


When('I log in again as {string}') do |username|
  @login_page = LoginPage.new
  @login_page.fill_credentials(username, 'secret_sauce')
  @login_page.submit
end

Given('I am not logged in') do
  visit '/'
  page.execute_script("window.localStorage.clear()")
  page.driver.browser.manage.delete_all_cookies
end

When('I attempt to navigate directly to the {string} at www.saucedemo.com\/{string}') do |page_name, url_extension|
  visit url_extension
end

Then('I should be redirected to the Login Page') do
  expect(current_url).to eq('https://www.saucedemo.com/') 
  expect(page).to have_selector('#login-button')
  expect(page).to have_selector('#user-name')
  expect(page).to have_selector('#password')
end

Then('I should see the error: Epic sadface: You can only access \/{string} when you are logged in.') do |url_extension|
  error_container = find('[data-test="error"]')
  expect(error_container.text).to eq("Epic sadface: You can only access '/#{url_extension}' when you are logged in.")
end

Given('the user Navigates to the Login Page of Sauce Demo') do
  visit '/'
end
Given('the user logs in as {string}') do |username|
  @login_page = LoginPage.new
  @login_page.fill_credentials(username, 'secret_sauce')
  @login_page.submit
end