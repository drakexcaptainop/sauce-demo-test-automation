
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

Then('I should be redirected to the Login Page') do
  expect(page).to have_current_path('/login')
  expect(page).to have_selector('#user-name')
  expect(page).to have_selector('#password')
end

When('I log in again as {string}') do |username|
  @login_page = LoginPage.new
  @login_page.fill_credentials(username, 'secret_sauce')
  @login_page.submit
end