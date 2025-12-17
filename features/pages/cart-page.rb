class CartPage
  include Capybara::DSL

  URL = '/cart.html'
  CHECKOUT_BTN = '#checkout'
  CONTINUE_SHOPPING_BTN = '#continue-shopping'
  CART_ITEM_NAME = '.inventory_item_name'
  CART_ITEM = '.cart_item'

  def visit_page
    visit URL
  end

  def click_checkout
    click_button('checkout')
  end

  def click_continue_shopping
    find(CONTINUE_SHOPPING_BTN).click
  end

  def get_cart_item_names
    all(CART_ITEM_NAME).map(&:text)
  end

  def has_checkout_button?
    has_button?(id: 'checkout')
  end
end
