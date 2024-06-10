# frozen_string_literal: true

require 'money'
require_relative '../../../lib/models/checkout'
require_relative '../../../lib/models/pricing_rules/pricing_rule'
require_relative '../../../lib/models/product'
require_relative '../../../lib/validators/checkout_validator'
require_relative '../../../lib/errors/validation_error'

RSpec.describe Checkout do
  let(:pricing_rules) { [] }
  let(:checkout) { described_class.new(pricing_rules) }
  let(:product) { Product.new('GR1', 'Product 1', 100, 'GBP') }

  describe '#initialize' do
    context 'with valid pricing rules' do
      it 'initializes without errors' do
        expect { checkout }.not_to raise_error
      end
    end

    context 'with invalid pricing rules' do
      let(:pricing_rules) { ['invalid'] }

      it 'raises a validation error' do
        expect do
          checkout
        end.to raise_error(ValidationError, 'Validation failed: Pricing rule must be an instance of PricingRule class')
      end
    end
  end

  describe '#scan' do
    it 'adds a product to the scanned products list' do
      expect { checkout.scan(product) }.to change { checkout.scanned_products.count }.by(1)
    end

    it 'raises a validation error for invalid products' do
      expect do
        checkout.scan('invalid')
      end.to raise_error(ValidationError,
                         'Validation failed: Product must be an instance of Product class')
    end
  end

  describe '#total' do
    let(:pricing_rules) { [PricingRule.new] }

    context 'with no scanned products' do
      it 'raises a validation error' do
        expect do
          checkout.total
        end.to raise_error(ValidationError, 'Validation failed: You must scan products to get total price')
      end
    end

    context 'with scanned products' do
      before { checkout.scan(product) }

      it 'calculates the total price based on the scanned products' do
        allow(pricing_rules.first).to receive(:can_handle?).and_return(false)
        allow(product).to receive(:price).and_return(Money.from_cents(100, 'GBP'))

        expect(checkout.total).to eq(Money.from_cents(100, 'GBP'))
      end

      it 'calculates the total price using pricing rules' do
        allow(pricing_rules.first).to receive(:can_handle?).and_return(true)
        allow(pricing_rules.first).to receive(:calculate).and_return(Money.from_cents(80, 'GBP'))

        expect(checkout.total).to eq(Money.from_cents(80, 'GBP'))
      end
    end
  end
end
