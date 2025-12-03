class LoginPage
  include Capybara::DSL

  URL           = '/'
  USER_FIELD    = '#user-name'
  PASS_FIELD    = '#password'
  LOGIN_BTN     = '#login-button'
  ERROR_BOX     = '[data-test="error"]'
  INVENTORY_URL = '/inventory.html'
  INVENTORY_ITEM_URL = '/inventory-item.html?id=0'

  def visit_page
    visit URL
  end

  def fill_credentials(user, pass)
    find(USER_FIELD).set(user)
    find(PASS_FIELD).set( pass )
  end

  def submit
    find(LOGIN_BTN).click
  end

  def check_login_status(expectation)
    if expectation == 'inventory'
      return page.current_url.include?(INVENTORY_URL)
    elsif expectation == 'error_message'
      return page.has_css?(ERROR_BOX)
    elsif expectation == 'inventory_item'
      return page.current_url.include?(INVENTORY_ITEM_URL)
    end
  end

  def get_error_message
    find(ERROR_BOX).text
  end
end