class CheckoutPage
  include Capybara::DSL

  def get_item_total_from_page
    price_elements = all('.inventory_item_price')
    calculated_sum = price_elements.map { |el| el.text.delete('$').to_f }.sum
    return calculated_sum
  end

  def get_page_totals
    calculated_sum  = self.get_item_total_from_page
    calculated_tax = (calculated_sum * ENV['tax_percentage'].to_f).round(2)
    calculated_total = (calculated_sum + calculated_tax).round(2)
    return [calculated_sum, calculated_tax, calculated_total]
  end
  
end