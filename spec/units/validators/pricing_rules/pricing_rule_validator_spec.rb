# frozen_string_literal: true

require 'money'
require_relative '../../../../lib/models/product'
require_relative '../../../../lib/validators/pricing_rules/pricing_rule_validator'
require_relative '../../../../lib/errors/validation_error'

RSpec.describe PricingRuleValidator do
  describe '.validate_product_code' do
    context 'with valid product code' do
      it 'does not raise an error' do
        expect { described_class.validate_product_code('GR1') }.not_to raise_error
      end
    end

    context 'with invalid product code' do
      it 'raises an error if product code is not a string' do
        expect do
          described_class.validate_product_code(123)
        end.to raise_error(ValidationError,
                           'Validation failed: Product code must be a non-empty string')
      end

      it 'raises an error if product code is empty' do
        expect do
          described_class.validate_product_code('')
        end.to raise_error(ValidationError,
                           'Validation failed: Product code must be a non-empty string')
      end
    end
  end

  describe '.validate_products' do
    context 'with valid products' do
      it 'does not raise an error' do
        products = [Product.new('GR1', 'Product 1', 100, 'GBP')]
        expect { described_class.validate_products(products) }.not_to raise_error
      end
    end

    context 'with invalid products' do
      it 'raises an error if products is not an array' do
        expect do
          described_class.validate_products('invalid')
        end.to raise_error(ValidationError,
                           'Validation failed: Products collection must be an array with products')
      end

      it 'raises an error if products array is empty' do
        expect do
          described_class.validate_products([])
        end.to raise_error(ValidationError,
                           'Validation failed: Products collection must be an array with products')
      end

      it 'raises an error if not all objects in the collection are instances of Product class' do
        products = [Product.new('GR1', 'Product 1', 100, 'GBP'), 'invalid']
        expect do
          described_class.validate_products(products)
        end.to raise_error(ValidationError,
                           'Validation failed: All objects in the collection must be instances of Product class')
      end
    end
  end
end
