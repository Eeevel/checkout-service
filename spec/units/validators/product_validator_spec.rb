# frozen_string_literal: true

require 'money'
require_relative '../../../lib/validators/product_validator'
require_relative '../../../lib/errors/validation_error'

RSpec.describe ProductValidator do
  describe '.validate' do
    context 'with valid product attributes' do
      let(:code) { 'GR1' }
      let(:name) { 'Product 1' }
      let(:price_cents) { 100 }
      let(:currency) { 'GBP' }

      it 'does not raise an error' do
        expect { described_class.validate(code, name, price_cents, currency) }.not_to raise_error
      end
    end

    context 'with invalid product attributes' do
      it 'raises an error if code is not a string' do
        expect do
          described_class.validate(123, 'Product 1', 100,
                                   'GBP')
        end.to raise_error(ValidationError, 'Validation failed: Code must be a non-empty string')
      end

      it 'raises an error if code is empty' do
        expect do
          described_class.validate('', 'Product 1', 100,
                                   'GBP')
        end.to raise_error(ValidationError, 'Validation failed: Code must be a non-empty string')
      end

      it 'raises an error if name is not a string' do
        expect do
          described_class.validate('GR1', 123, 100,
                                   'GBP')
        end.to raise_error(ValidationError, 'Validation failed: Name must be a non-empty string')
      end

      it 'raises an error if name is empty' do
        expect do
          described_class.validate('GR1', '', 100,
                                   'GBP')
        end.to raise_error(ValidationError, 'Validation failed: Name must be a non-empty string')
      end

      it 'raises an error if price is not a number' do
        expect do
          described_class.validate('GR1', 'Product 1', 'invalid',
                                   'GBP')
        end.to raise_error(ValidationError, 'Validation failed: Price must be a positive or zero number')
      end

      it 'raises an error if price is negative' do
        expect do
          described_class.validate('GR1', 'Product 1', -100,
                                   'GBP')
        end.to raise_error(ValidationError, 'Validation failed: Price must be a positive or zero number')
      end

      it 'raises an error if currency is invalid' do
        expect do
          described_class.validate('GR1', 'Product 1', 100,
                                   'INVALID')
        end.to raise_error(ValidationError, 'Validation failed: Invalid currency')
      end
    end
  end
end
