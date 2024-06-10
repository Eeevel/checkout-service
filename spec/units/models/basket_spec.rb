# frozen_string_literal: true

require_relative '../../../lib/models/basket'
require_relative '../../../lib/validators/basket_validator'
require_relative '../../../lib/errors/validation_error'

RSpec.describe Basket do
  let(:basket) { described_class.new }

  describe '#initialize' do
    it 'initializes an empty product codes array' do
      expect(basket.product_codes).to eq([])
    end
  end

  describe '#add_item' do
    context 'with a valid product code' do
      it 'adds the product code to the basket' do
        expect { basket.add_item('GR1') }.to change { basket.product_codes.length }.by(1)
      end
    end

    context 'with an invalid product code' do
      it 'raises a validation error' do
        expect do
          basket.add_item(nil)
        end.to raise_error(ValidationError, 'Validation failed: Code must be a non-empty string')
      end
    end
  end
end
