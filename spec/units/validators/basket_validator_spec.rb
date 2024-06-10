# frozen_string_literal: true

require_relative '../../../lib/validators/basket_validator'
require_relative '../../../lib/errors/validation_error'

RSpec.describe BasketValidator do
  describe '.validate' do
    context 'with valid code' do
      it 'does not raise an error' do
        expect { described_class.validate('B001') }.not_to raise_error
      end
    end

    context 'with invalid code' do
      it 'raises an error if code is not a string' do
        expect do
          described_class.validate(123)
        end.to raise_error(ValidationError, 'Validation failed: Code must be a non-empty string')
      end

      it 'raises an error if code is empty' do
        expect do
          described_class.validate('')
        end.to raise_error(ValidationError, 'Validation failed: Code must be a non-empty string')
      end
    end
  end
end
