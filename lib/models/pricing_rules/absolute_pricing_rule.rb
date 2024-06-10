# frozen_string_literal: true

require_relative 'pricing_rule'
require_relative '../../validators/pricing_rules/absolute_pricing_rule_validator'

class AbsolutePricingRule < PricingRule
  attr_reader :discount_price

  def initialize(required_product_code, required_count, discount_price)
    AbsolutePricingRuleValidator.validate_initializer(required_product_code, required_count, discount_price)

    @required_product_code = required_product_code
    @required_count = required_count
    @discount_price = discount_price
  end

  def can_handle?(product_code)
    AbsolutePricingRuleValidator.validate_product_code(product_code)

    product_code == required_product_code
  end

  def calculate(products)
    AbsolutePricingRuleValidator.validate_products(products)

    count = products.count

    if count >= required_count
      count * discount_price
    else
      price = products.first.price
      count * price
    end
  end
end
