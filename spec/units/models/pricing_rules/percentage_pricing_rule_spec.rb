# frozen_string_literal: true

require 'money'
require_relative '../../../../lib/models/pricing_rules/percentage_pricing_rule'
require_relative '../../../../lib/validators/pricing_rules/percentage_pricing_rule_validator'
require_relative '../../../../lib/errors/validation_error'
require_relative '../../../../lib/models/product'

RSpec.describe PercentagePricingRule do
  describe '#initialize' do
    let(:required_product_code) { 'GR1' }
    let(:required_count) { 3 }
    let(:percentage) { 10 }

    context 'with valid arguments' do
      it 'initializes with required arguments' do
        expect { described_class.new(required_product_code, required_count, percentage) }.not_to raise_error
      end
    end

    context 'with invalid arguments' do
      it 'raises an error if required_product_code is not a string' do
        expect do
          described_class.new(123, required_count,
                              percentage)
        end.to raise_error(ValidationError, 'Validation failed: Product code must be a non-empty string')
      end

      it 'raises an error if required_product_code is empty' do
        expect do
          described_class.new('', required_count,
                              percentage)
        end.to raise_error(ValidationError, 'Validation failed: Product code must be a non-empty string')
      end

      it 'raises an error if required_count is not an integer' do
        expect do
          described_class.new(required_product_code, 'invalid',
                              percentage)
        end.to raise_error(ValidationError, 'Validation failed: Count must be an Integer digit')
      end

      it 'raises an error if percentage is not numeric' do
        expect do
          described_class.new(required_product_code, required_count,
                              'invalid')
        end.to raise_error(ValidationError, 'Validation failed: Percentage must be a positive or zero number')
      end

      it 'raises an error if percentage is negative' do
        expect do
          described_class.new(required_product_code, required_count,
                              -10)
        end.to raise_error(ValidationError, 'Validation failed: Percentage must be a positive or zero number')
      end
    end
  end

  describe '#can_handle?' do
    let(:product_code) { 'GR1' }

    it 'returns true if it can handle the product' do
      pricing_rule = described_class.new(product_code, 3, 10)
      expect(pricing_rule.can_handle?('GR1')).to be_truthy
    end

    it 'returns false if it cannot handle the product' do
      pricing_rule = described_class.new('SR1', 3, 10)
      expect(pricing_rule.can_handle?('GR1')).to be_falsey
    end
  end

  describe '#calculate' do
    let(:product) { Product.new('GR1', 'Product 1', 100, 'GBP') }

    context 'when products meet the required count' do
      let(:products) { [product, product, product] }

      it 'applies the percentage discount' do
        pricing_rule = described_class.new('GR1', 3, 10)
        expect(pricing_rule.calculate(products)).to eq(Money.from_cents(270, 'GBP')) # (3 * 100 * (1 - 10/100)) = 270
      end
    end

    context 'when products do not meet the required count' do
      let(:products) { [product, product] }

      it 'applies the regular price' do
        pricing_rule = described_class.new('GR1', 3, 10)
        expect(pricing_rule.calculate(products)).to eq(Money.from_cents(200, 'GBP')) # 2 * 100 = 200
      end
    end
  end
end
