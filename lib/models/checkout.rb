# frozen_string_literal: true

require_relative '../validators/checkout_validator'

class Checkout
  attr_reader :scanned_products

  def initialize(pricing_rules)
    CheckoutValidator.validate_pricing_rules(pricing_rules)

    @pricing_rules = pricing_rules
    @scanned_products = []
  end

  def scan(product)
    CheckoutValidator.validate_product(product, scanned_products)

    scanned_products << product
  end

  def total
    CheckoutValidator.validate_total(scanned_products)

    currency = scanned_products.first.price.currency
    total_price = Money.from_cents(0, currency)
    scanned_products_hash = scanned_products.group_by(&:code)

    scanned_products_hash.each do |product_code, products|
      total_price += if (handler = pricing_rules.find { |rule| rule.can_handle?(product_code) })
                       handler.calculate(products)
                     else
                       products.first.price * products.count
                     end
    end
    total_price
  end

  private

  attr_reader :pricing_rules
end
