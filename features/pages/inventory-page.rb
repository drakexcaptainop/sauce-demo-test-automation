require_relative 'page_utils/singleton'

class InventoryPage < SingletonPageParent
  include Capybara::DSL

  URL = '/inventory.html'
  CLASS_INVENTORY_ITEM = '.inventory_item'
  CLASS_INVENTORY_ITEM_NAME = '.inventory_item_name'
  CLASS_INVENTORY_ITEM_PRICE = '.inventory_item_price'
  CLASS_ADD_TO_CART_BTN = 'button.btn_inventory'
  CLASS_SHOPPING_CART_BADGE = 'span.shopping_cart_badge'
  CLASS_SHOPPING_CART_LINK = '.shopping_cart_link'
  CLASS_INVENTORY_ITEM_IMG = 'img.inventory_item_img'
  CLASS_TITLE = 'span.title'
  CLASS_SIDE_MENU = '.bm-menu-wrap'
  CLASS_SIDE_BAR_MENU_ITEM = '.bm-item.menu-item'

  ID_SIDE_BAR_LINK = '#inventory_sidebar_link'
  ID_INVENTORY_CONTAINER = '#inventory_container'
  ID_BURGER_MENU_BTN = '#react-burger-menu-btn'
  ID_LOGOUT_SIDEBAR_LINK = '#logout_sidebar_link'


  REMOVE_BTN = 'Remove'
  ADD_TO_CART_BTN = 'Add to cart'

  def click_product_name(product_name)
    get_product_by_text(product_name).find(CLASS_INVENTORY_ITEM_NAME).click
  end

  def get_product_by_text(item_name)
    find(CLASS_INVENTORY_ITEM, text: item_name)
  end

  def click_product_button(item_name, button_name)
    get_product_by_text(item_name).click_button(button_name)
  end

  def add_all_products_to_cart
    all("button.btn_inventory").each do |btn|
      btn.click if btn.text == ADD_TO_CART_BTN
    end
  end

  def remove_all_products_from_cart
    all("button.btn_inventory").each do |btn|
      btn.click if btn.text == REMOVE_BTN
    end
  end

  def get_shopping_cart_badge_count_as_str
    find(CLASS_SHOPPING_CART_BADGE).text
  end

  def click_shopping_cart_link
    find(CLASS_SHOPPING_CART_LINK).click
  end

  def click_burger_menu_btn
    find(ID_BURGER_MENU_BTN).click
  end

  def click_logout_sidebar_link
    find(ID_LOGOUT_SIDEBAR_LINK).click
  end

  def get_all_product_names
    all(CLASS_INVENTORY_ITEM_NAME).map(&:text)
  end

  def get_all_product_prices
    all(CLASS_INVENTORY_ITEM_PRICE).map(&:text)
  end

  def get_all_products_name_price_pairs
    get_all_product_names.zip(get_all_product_prices)
  end

  def get_product_img_src(product_name)
    product_div = get_product_by_text(product_name)
    img_src = product_div.find(CLASS_INVENTORY_ITEM_IMG)[:src]
    return img_src
  end

  def get_all_products_img_srcs
    all(CLASS_INVENTORY_ITEM_IMG).map{|img| img[:src]}
  end

  def get_product_count
    all(CLASS_INVENTORY_ITEM).count
  end

  def add_products_to_cart(product_names)
    product_names.each do |product_name|
      click_product_button(product_name, ADD_TO_CART_BTN)
    end
  end

  def remove_products_from_cart(product_names)
    product_names.each do |product_name|
      click_product_button(product_name, REMOVE_BTN)
    end
  end

  def get_title_text
    find(CLASS_TITLE).text
  end 
    
  def visit_page
    visit URL 
  end
  def get_title_text 
    find(CLASS_TITLE).text
  end
end
