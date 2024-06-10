# frozen_string_literal: true

require_relative '../pricing_rules/pricing_rule_validator'
require_relative '../../errors/validation_error'

class AbsolutePricingRuleValidator < PricingRuleValidator
  class << self
    def validate_initializer(required_product_code, required_count, discount_price)
      errors = []

      if !required_product_code.is_a?(String) || required_product_code.empty?
        errors << 'Product code must be a non-empty string'
      end

      errors << 'Count must be an Integer digit' unless required_count.is_a?(Integer)

      if discount_price.nil? || !discount_price.is_a?(Money) || discount_price.negative?
        errors << 'Discount price must be a positive or zero number'
      end

      raise ValidationError, errors unless errors.empty?
    end
  end
end
