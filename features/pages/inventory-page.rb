class InventoryPage
  include Capybara::DSL

  CART_BADGE = '.shopping_cart_badge'

  def add_product_to_cart(product_name)
    slug = product_name.downcase.gsub(' ', '-')
    button_id = "#add-to-cart-#{slug}"
    find(button_id).click
  end

  def click_reset_app_state
    find("#reset_sidebar_link").click
  end

  def open_left_sidebar_menu
    find('.bm-burger-button').click
  end

  def get_cart_count
    if page.has_css?(CART_BADGE)
      return find(CART_BADGE).text
    else
      return "0"
    end
  end

  def check_button_state(product_name, expected_text)
    slug = product_name.downcase.gsub(' ', '-')
    
    if expected_text.downcase == 'remove'
      button_id = "#remove-#{slug}"
    else
      button_id = "#add-to-cart-#{slug}"
    end

    return find(button_id).text == expected_text
  end
end