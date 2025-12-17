require_relative 'inventory-page'
require_relative 'page_utils/singleton'

class ProductDetailsPage < SingletonPageParent
  include Capybara::DSL

  URL = '/inventory-item.html'

  ID_BACK_TO_PRODUCTS_BTN = '#back-to-products'

  DATA_TEST_INVENTORY_ITEM_NAME = '[data-test="inventory-item-name"]'
  DATA_TEST_INVETORY_ITEM_DESCRIPTION = '[data-test="inventory-item-desc"]'
  DATA_TEST_INVENTORY_ITEM_PRICE = '[data-test="inventory-item-price"]'
  DATA_TEST_ADD_TO_CART_BTN = '[data-test="add-to-cart"]'


  def visit_page(product_name)
    InventoryPage.instance.click_product_name(product_name)
  end

  def click_add_to_cart
    find(DATA_TEST_ADD_TO_CART_BTN).click
  end


  def click_back_to_products_btn
    find(ID_BACK_TO_PRODUCTS_BTN).click
  end

  def get_product_name 
    find(DATA_TEST_INVENTORY_ITEM_NAME).text
  end
  def get_product_description
    find(DATA_TEST_INVETORY_ITEM_DESCRIPTION).text
  end
  def get_product_price
    find(DATA_TEST_INVENTORY_ITEM_PRICE)
  end
end
