# frozen_string_literal: true

require_relative '../pricing_rules/pricing_rule_validator'
require_relative '../../errors/validation_error'

class PercentagePricingRuleValidator < PricingRuleValidator
  class << self
    def validate_initializer(required_product_code, required_count, percentage)
      errors = []

      if !required_product_code.is_a?(String) || required_product_code.empty?
        errors << 'Product code must be a non-empty string'
      end

      errors << 'Count must be an Integer digit' unless required_count.is_a?(Integer)

      if percentage.nil? || !percentage.is_a?(Numeric) || percentage.negative?
        errors << 'Percentage must be a positive or zero number'
      end

      raise ValidationError, errors unless errors.empty?
    end
  end
end
