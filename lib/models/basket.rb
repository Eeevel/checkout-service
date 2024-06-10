# frozen_string_literal: true

require_relative '../validators/basket_validator'

class Basket
  attr_reader :product_codes

  def initialize
    @product_codes = []
  end

  def add_item(product_code)
    BasketValidator.validate(product_code)

    product_codes << product_code
  end
end
