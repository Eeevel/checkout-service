# frozen_string_literal: true

require_relative 'pricing_rule_repository'

class PricingRuleHashRepository < PricingRuleRepository
  def initialize
    @pricing_rules = {}
  end

  def create(pricing_rule)
    pricing_rules[pricing_rule.required_product_code] = pricing_rule
  end

  def find_by_code(code)
    pricing_rules[code]
  end

  def all
    pricing_rules.values
  end

  def update(code, pricing_rule)
    pricing_rules[code] = pricing_rule
  end

  def delete(code)
    pricing_rules.delete(code)
  end
end
