# frozen_string_literal: true

require 'money'
require_relative '../../../lib/validators/checkout_validator'
require_relative '../../../lib/errors/validation_error'
require_relative '../../../lib/models/pricing_rules/pricing_rule'
require_relative '../../../lib/models/product'

RSpec.describe CheckoutValidator do
  describe '.validate_pricing_rules' do
    let(:valid_pricing_rule) { PricingRule.new }
    let(:invalid_pricing_rule) { 'invalid' }

    context 'with valid pricing rules' do
      it 'does not raise an error' do
        expect { described_class.validate_pricing_rules([valid_pricing_rule]) }.not_to raise_error
      end
    end

    context 'with invalid pricing rules' do
      it 'raises an error if any pricing rule is not an instance of PricingRule' do
        expect do
          described_class.validate_pricing_rules([valid_pricing_rule,
                                                  invalid_pricing_rule])
        end.to raise_error(ValidationError, 'Validation failed: Pricing rule must be an instance of PricingRule class')
      end
    end
  end

  describe '.validate_product' do
    let(:code) { 'GR1' }
    let(:name) { 'Example Product' }
    let(:price_cents) { 1000 }
    let(:currency) { 'GBP' }
    let(:product) { Product.new(code, name, price_cents, currency) }
    let(:currency_usd) { 'USD' }
    let(:product_usd) { Product.new(code, name, price_cents, currency_usd) }
    let(:scanned_products) { [product] }

    context 'with a valid product' do
      it 'does not raise an error' do
        expect { described_class.validate_product(product, scanned_products) }.not_to raise_error
      end
    end

    context 'with an invalid product' do
      it 'raises an error if product is nil' do
        expect do
          described_class.validate_product(nil,
                                           scanned_products)
        end.to raise_error(ValidationError, 'Validation failed: This product does not exist')
      end

      it 'raises an error if product is not an instance of Product' do
        expect do
          described_class.validate_product('invalid',
                                           scanned_products)
        end.to raise_error(ValidationError, 'Validation failed: Product must be an instance of Product class')
      end

      it 'raises an error if product currency differs from other products' do
        expect do
          described_class.validate_product(product_usd,
                                           scanned_products)
        end.to raise_error(ValidationError,
                           'Validation failed: Product must have the same currency like other products')
      end
    end
  end

  describe '.validate_total' do
    let(:scanned_products) { [] }

    context 'with valid scanned products' do
      let(:code) { 'GR1' }
      let(:name) { 'Example Product' }
      let(:price_cents) { 1000 }
      let(:currency) { 'GBP' }
      let(:product) { Product.new(code, name, price_cents, currency) }
      let(:scanned_products) { [product] }

      it 'does not raise an error' do
        expect { described_class.validate_total(scanned_products) }.not_to raise_error
      end
    end

    context 'with no scanned products' do
      it 'raises an error' do
        expect do
          described_class.validate_total(scanned_products)
        end.to raise_error(ValidationError,
                           'Validation failed: You must scan products to get total price')
      end
    end
  end
end
