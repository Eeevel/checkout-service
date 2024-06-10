# frozen_string_literal: true

require_relative 'pricing_rule'
require_relative '../../validators/pricing_rules/percentage_pricing_rule_validator'

class PercentagePricingRule < PricingRule
  attr_reader :percentage

  def initialize(required_product_code, required_count, percentage)
    PercentagePricingRuleValidator.validate_initializer(required_product_code, required_count, percentage)

    @required_product_code = required_product_code
    @required_count = required_count
    @percentage = percentage
  end

  def can_handle?(product_code)
    PercentagePricingRuleValidator.validate_product_code(product_code)

    product_code == required_product_code
  end

  def calculate(products)
    PercentagePricingRuleValidator.validate_products(products)

    count = products.count
    price = products.first.price

    if count >= required_count
      count * price * (1 - Rational(percentage, 100))
    else
      count * price
    end
  end
end
