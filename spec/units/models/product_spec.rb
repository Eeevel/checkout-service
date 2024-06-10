# frozen_string_literal: true

require 'money'
require_relative '../../../lib/models/product'

RSpec.describe Product do
  let(:code) { 'GR1' }
  let(:name) { 'Example Product' }
  let(:price_cents) { 1000 }
  let(:currency) { 'GBP' }

  subject(:product) { described_class.new(code, name, price_cents, currency) }

  describe '#initialize' do
    it 'initializes with required arguments' do
      expect(product.code).to eq(code)
      expect(product.name).to eq(name)
      expect(product.price).to eq(Money.from_cents(price_cents, currency))
    end

    it 'raises an error if price_cents is not an integer' do
      expect { described_class.new(code, name, 'invalid', currency) }.to raise_error(ValidationError)
    end

    it 'raises an error if currency is not a valid currency code' do
      expect { described_class.new(code, name, price_cents, 'invalid_currency') }.to raise_error(ValidationError)
    end
  end
end
