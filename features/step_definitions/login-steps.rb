

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