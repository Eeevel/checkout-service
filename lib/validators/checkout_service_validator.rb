# frozen_string_literal: true

require_relative '../errors/validation_error'

class CheckoutServiceValidator
  class << self
    def validate_initializer(pricing_rule_repository, product_repository)
      errors = []

      unless pricing_rule_repository.is_a?(PricingRuleRepository)
        errors << 'Pricing rule repository must be an instance of PricingRuleRepository class'
      end

      unless product_repository.is_a?(ProductRepository)
        errors << 'Product repository must be an instance of ProductRepository class'
      end

      raise ValidationError, errors unless errors.empty?
    end

    def validate_basket(basket)
      errors = []

      errors << 'Basket must be an instance of Basket class' unless basket.is_a?(Basket)

      raise ValidationError, errors unless errors.empty?
    end
  end
end
