# frozen_string_literal: true

require_relative 'pricing_rule'
require_relative '../../validators/pricing_rules/bonus_product_pricing_rule_validator'

class BonusProductPricingRule < PricingRule
  def initialize(required_product_code, required_count)
    BonusProductPricingRuleValidator.validate_initializer(required_product_code, required_count)

    @required_product_code = required_product_code
    @required_count = required_count
  end

  def can_handle?(product_code)
    BonusProductPricingRuleValidator.validate_product_code(product_code)

    product_code == required_product_code
  end

  def calculate(products)
    BonusProductPricingRuleValidator.validate_products(products)

    count = products.count
    price = products.first.price

    if count >= required_count
      (count / 2 + count % 2) * price
    else
      count * price
    end
  end
end
