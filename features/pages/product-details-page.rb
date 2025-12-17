class ProductDetailsPage
  include Capybara::DSL

  BACK_TO_PRODUCTS_BTN = '#back-to-products'
  PRODUCT_NAME = '[data-test="inventory-item-name"]'
  PRODUCT_DESC = '[data-test="inventory-item-desc"]'
  ADD_TO_CART_BTN = 'button.btn_inventory'

  def click_back_to_products
    find(BACK_TO_PRODUCTS_BTN).click
  end

  def get_product_name
    find(PRODUCT_NAME).text
  end

  def get_product_description
    find(PRODUCT_DESC).text
  end

  def add_to_cart
    click_button('Add to cart')
  end
end
