# frozen_string_literal: true

require_relative '../validators/product_validator'

class Product
  attr_reader :code, :name, :price

  def initialize(code, name, price_cents, currency)
    ProductValidator.validate(code, name, price_cents, currency)

    @code = code
    @name = name
    @price = Money.from_cents(price_cents, currency)
  end
end
