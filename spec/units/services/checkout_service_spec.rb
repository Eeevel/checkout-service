# frozen_string_literal: true

require 'money'
require_relative '../../../lib/services/checkout_service'
require_relative '../../../lib/models/checkout'
require_relative '../../../lib/models/basket'
require_relative '../../../lib/models/product'
require_relative '../../../lib/models/pricing_rules/absolute_pricing_rule'
require_relative '../../../lib/validators/checkout_service_validator'
require_relative '../../../lib/repositories/pricing_rules/pricing_rule_hash_repository'
require_relative '../../../lib/repositories/products/product_hash_repository'
require_relative '../../../lib/errors/validation_error'

RSpec.describe CheckoutService do
  let(:pricing_rule_repository) { PricingRuleHashRepository.new }
  let(:product_repository) { ProductHashRepository.new }
  let(:service) { described_class.new(pricing_rule_repository, product_repository) }
  let(:basket) { Basket.new }

  describe '#initialize' do
    it 'initializes with valid repositories' do
      expect { service }.not_to raise_error
    end

    it 'raises an error with invalid pricing rule repository' do
      expect do
        described_class.new(nil,
                            product_repository)
      end.to raise_error(ValidationError,
                         'Validation failed: Pricing rule repository must be an instance of PricingRuleRepository class')
    end

    it 'raises an error with invalid product repository' do
      expect do
        described_class.new(pricing_rule_repository,
                            nil)
      end.to raise_error(ValidationError,
                         'Validation failed: Product repository must be an instance of ProductRepository class')
    end
  end

  describe '#checkout' do
    let(:product1) { Product.new('GR1', 'Product 1', 100, 'GBP') }
    let(:product2) { Product.new('SR1', 'Product 2', 200, 'GBP') }
    let(:pricing_rule) { AbsolutePricingRule.new('GR1', 2, Money.from_cents(1500, 'GBP')) }

    before do
      pricing_rule_repository.create(pricing_rule)
      product_repository.create(product1)
      product_repository.create(product2)
    end

    it 'returns the total price of scanned products' do
      basket.add_item('GR1')
      basket.add_item('SR1')
      expect(service.checkout(basket)).to eq(Money.from_cents(300, 'GBP'))
    end

    it 'raises an error for an empty basket' do
      expect do
        service.checkout(basket)
      end.to raise_error(ValidationError,
                         'Validation failed: You must scan products to get total price')
    end
  end
end
