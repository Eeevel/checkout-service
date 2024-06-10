# frozen_string_literal: true

require_relative '../errors/validation_error'

class CheckoutValidator
  class << self
    def validate_pricing_rules(pricing_rules)
      errors = []

      incorrect_type_count = pricing_rules.count do |pricing_rule|
        !pricing_rule.is_a?(PricingRule)
      end

      errors << 'Pricing rule must be an instance of PricingRule class' if incorrect_type_count.positive?

      raise ValidationError, errors unless errors.empty?
    end

    def validate_product(product, scanned_products)
      errors = []

      if product.nil?
        errors << 'This product does not exist'
      elsif !product.is_a?(Product)
        errors << 'Product must be an instance of Product class'
      elsif !scanned_products.empty? && scanned_products.first.price.currency != product.price.currency
        errors << 'Product must have the same currency like other products'
      end

      raise ValidationError, errors unless errors.empty?
    end

    def validate_total(scanned_products)
      errors = []

      errors << 'You must scan products to get total price' if scanned_products.empty?

      raise ValidationError, errors unless errors.empty?
    end
  end
end
