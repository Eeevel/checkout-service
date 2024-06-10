# frozen_string_literal: true

require 'money'
require_relative '../../../../lib/validators/pricing_rules/absolute_pricing_rule_validator'
require_relative '../../../../lib/errors/validation_error'

RSpec.describe AbsolutePricingRuleValidator do
  describe '.validate_initializer' do
    context 'with valid arguments' do
      it 'does not raise an error' do
        expect { described_class.validate_initializer('GR1', 3, Money.from_cents(25, 'GBP')) }.not_to raise_error
      end
    end

    context 'with invalid arguments' do
      it 'raises an error if required_product_code is not a string' do
        expect do
          described_class.validate_initializer(123, 3,
                                               Money.from_cents(25, 'GBP'))
        end.to raise_error(ValidationError, 'Validation failed: Product code must be a non-empty string')
      end

      it 'raises an error if required_product_code is empty' do
        expect do
          described_class.validate_initializer('', 3,
                                               Money.from_cents(25, 'GBP'))
        end.to raise_error(ValidationError, 'Validation failed: Product code must be a non-empty string')
      end

      it 'raises an error if required_count is not an integer' do
        expect do
          described_class.validate_initializer('GR1', 'invalid',
                                               Money.from_cents(25, 'GBP'))
        end.to raise_error(ValidationError, 'Validation failed: Count must be an Integer digit')
      end

      it 'raises an error if discount_price is not numeric' do
        expect do
          described_class.validate_initializer('GR1', 3,
                                               'invalid')
        end.to raise_error(ValidationError, 'Validation failed: Discount price must be a positive or zero number')
      end

      it 'raises an error if discount_price is negative' do
        expect do
          described_class.validate_initializer('GR1', 3,
                                               Money.from_cents(-25, 'GBP'))
        end.to raise_error(ValidationError, 'Validation failed: Discount price must be a positive or zero number')
      end

      it 'raises an error if discount_price is nil' do
        expect do
          described_class.validate_initializer('GR1', 3,
                                               nil)
        end.to raise_error(ValidationError, 'Validation failed: Discount price must be a positive or zero number')
      end
    end
  end
end
