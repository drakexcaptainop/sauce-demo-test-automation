require_relative 'page_utils/singleton'

class YourCartPage < SingletonPageParent
  include Capybara::DSL
  URL = '/cart.html'
  CLASS_TITLE = '.title'
  CLASS_CART_LIST = '.cart_list'
  CLASS_INVENTORY_ITEM = '.inventory_item'
  CLASS_INVENTORY_ITEM_NAME = '.inventory_item_name'
  CLASS_INVENTORY_ITEM_PRICE = '.inventory_item_price'
  CLASS_CHECKOUT_BTN = '.checkout_button'
  
  ID_CONTINUE_SHOPPING_BTN = '#continue-shopping'
  
  def click_checkout_btn
    find(CLASS_CHECKOUT_BTN).click
  end

  def click_continue_shopping_btn
    find(ID_CONTINUE_SHOPPING_BTN).click
  end

  def get_all_product_names
    all(CLASS_INVENTORY_ITEM_NAME).map(&:text)
  end

  def visit_page
    visit URL 
  end
  def get_title_text 
    find(CLASS_TITLE).text
  end
end


class CheckoutYourInformationPage < SingletonPageParent
  URL = '/checkout-step-one.html'
  CLASS_TITLE = '.title'
  ID_FIRST_NAME_FIELD = '#first-name'
  ID_LAST_NAME_FIELD = '#last-name'
  ID_ZIP_CODE_FIELD = '#postal-code'
  ID_CONTINUE_BTN = '#continue'
  ID_CANCEL_BTN = '#cancel'

  DATA_TEST_ERROR_CONTAINER = '[data-test="error"]'
  FORM_ELEMENTS = ['first-name', 'last-name', 'postal-code']
  
  def fill_in_form(first_name, last_name, zip_code)
    find(ID_FIRST_NAME_FIELD).set(first_name)
    find(ID_LAST_NAME_FIELD).set(last_name)
    find(ID_ZIP_CODE_FIELD).set(zip_code)
  end
  
  def get_error_container_text
    find(DATA_TEST_ERROR_CONTAINER).text
  end

  def click_continue_btn
    find(ID_CONTINUE_BTN).click
  end
  
  def click_cancel_btn
    find(ID_CANCEL_BTN).click
  end

  def get_first_name_form_value
    find(ID_FIRST_NAME_FIELD).value
  end

  def get_last_name_form_value
    find(ID_LAST_NAME_FIELD).value
  end

  def get_zip_code_form_value
    find(ID_ZIP_CODE_FIELD).value
  end

  def visit_page
    visit URL 
  end
  def get_title_text 
    find(CLASS_TITLE).text
  end
    
end


class CheckoutOverviewPage < SingletonPageParent
  include Capybara::DSL
  URL = '/checkout-step-two.html'
  CLASS_TITLE = '.title'
  CLASS_CART_LIST = '.cart_list'
  CLASS_INVENTORY_ITEM = '.cart_item'
  CLASS_INVENTORY_ITEM_PRICE = '.inventory_item_price'
  CLASS_CANCEL_BTN = '.cancel_button'
  CLASS_SUBTOTAL = '.summary_subtotal_label'
  CLASS_TAX = '.summary_tax_label'
  CLASS_TOTAL = '.summary_total_label'

  DATA_TEST_SUBTOTAL = '[data-test="subtotal-label"]'
  DATA_TEST_TAX = '[data-test="tax-label"]'
  DATA_TEST_TOTAL = '[data-test="total-label"]'
  DATA_TEST_INVENTORY_ITEM_PRICE = '[data-test="inventory-item-price"]'
  DATA_TEST_INVENTORY_ITEM = '[data-test="inventory_item"]'

  ID_FINISH_BTN = '#finish'
  ID_CANCEL_BTN = '#cancel'
  TAX_PERCENTAGE = 0.08


  def click_finish_btn
    find(ID_FINISH_BTN).click
  end

  def click_cancel_btn
    find(ID_CANCEL_BTN).click
  end

  def get_subtotal_as_f
    find(CLASS_SUBTOTAL).text.delete('Item total: $').to_f
  end

  def get_tax_as_f
    find(CLASS_TAX).text.delete('Tax: $').to_f
  end

  def get_total_as_f
    find(CLASS_TOTAL).text.delete('Total: $').to_f
  end

  def get_item_total_from_product_list
    price_elements = all(DATA_TEST_INVENTORY_ITEM_PRICE)
    calculated_sum = price_elements.map { |el| el.text.delete('$').to_f }.sum
    return calculated_sum
  end

  def get_page_totals 
    item_total = get_item_total_from_product_list.round(2)
    tax = (item_total * TAX_PERCENTAGE).round(2)
    total = (item_total + tax).round(2)
    return [item_total, tax, total]
  end

  def visit_page
    visit URL 
  end
  def get_title_text 
    find(CLASS_TITLE).text
  end
end



class CheckoutCompletePage < SingletonPageParent
  include Capybara::DSL
  URL = '/checkout-complete.html'
  CLASS_TITLE = '.title'
  CLASS_COMPLETE_HEADER = '.complete-header'
  CLASS_COMPLETE_TEXT = '.complete-text'

  ID_BACK_HOME_BTN = '#back-to-products'
  def get_back_home_btn_text
    find(ID_BACK_HOME_BTN).text
  end

  def get_header_message_text
    find(CLASS_COMPLETE_HEADER).text
  end

  def visit_page
    visit URL 
  end
  def get_title_text 
    find(CLASS_TITLE).text
  end
end