# frozen_string_literal: true

require_relative '../../errors/validation_error'

class PricingRuleValidator
  class << self
    def validate_product_code(product_code)
      errors = []

      errors << 'Product code must be a non-empty string' if !product_code.is_a?(String) || product_code.empty?

      raise ValidationError, errors unless errors.empty?
    end

    def validate_products(products)
      errors = []

      if !products.is_a?(Array) || products.empty?
        errors << 'Products collection must be an array with products'
      elsif !products.all? { |product| product.is_a?(Product) }
        errors << 'All objects in the collection must be instances of Product class'
      end

      raise ValidationError, errors unless errors.empty?
    end
  end
end
