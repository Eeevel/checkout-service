# frozen_string_literal: true

require 'money'
require_relative '../../lib/services/checkout_service'
require_relative '../../lib/models/product'
require_relative '../../lib/models/basket'
require_relative '../../lib/models/pricing_rules/absolute_pricing_rule'
require_relative '../../lib/models/pricing_rules/percentage_pricing_rule'
require_relative '../../lib/models/pricing_rules/bonus_product_pricing_rule'
require_relative '../../lib/repositories/pricing_rules/pricing_rule_hash_repository'
require_relative '../../lib/repositories/products/product_hash_repository'
require_relative '../../lib/errors/validation_error'

RSpec.describe 'Checkout process' do
  let(:pricing_rule_repository) { PricingRuleHashRepository.new }
  let(:product_repository) { ProductHashRepository.new }
  let(:checkout_service) { CheckoutService.new(pricing_rule_repository, product_repository) }
  let(:basket) { Basket.new }

  before do
    pricing_rule_repository.create(AbsolutePricingRule.new('SR1', 3, Money.from_cents(450, 'GBP')))
    pricing_rule_repository.create(PercentagePricingRule.new('CF1', 3, (1 - Rational(2, 3)) * 100))
    pricing_rule_repository.create(BonusProductPricingRule.new('GR1', 1))

    product_repository.create(Product.new('GR1', 'Green tea', 311, 'GBP'))
    product_repository.create(Product.new('SR1', 'Strawberries', 500, 'GBP'))
    product_repository.create(Product.new('CF1', 'Coffee', 1123, 'GBP'))
  end

  it 'calculates the total price correctly for a basket with GR1, SR1, GR1, GR1, CF1 products' do
    basket.add_item('GR1')
    basket.add_item('SR1')
    basket.add_item('GR1')
    basket.add_item('GR1')
    basket.add_item('CF1')
    expect(checkout_service.checkout(basket)).to eq(Money.from_cents(2245, 'GBP'))
  end

  it 'calculates the total price correctly for a basket with GR1, GR1 products' do
    basket.add_item('GR1')
    basket.add_item('GR1')
    expect(checkout_service.checkout(basket)).to eq(Money.from_cents(311, 'GBP'))
  end

  it 'calculates the total price correctly for a basket with SR1, SR1, GR1, SR1 products' do
    basket.add_item('SR1')
    basket.add_item('SR1')
    basket.add_item('GR1')
    basket.add_item('SR1')
    expect(checkout_service.checkout(basket)).to eq(Money.from_cents(1661, 'GBP'))
  end

  it 'calculates the total price correctly for a basket with GR1, CF1, SR1, CF1, CF1 products' do
    basket.add_item('GR1')
    basket.add_item('CF1')
    basket.add_item('SR1')
    basket.add_item('CF1')
    basket.add_item('CF1')
    expect(checkout_service.checkout(basket)).to eq(Money.from_cents(3057, 'GBP'))
  end

  it 'raises an error if the basket is empty' do
    expect do
      checkout_service.checkout(basket)
    end.to raise_error(ValidationError,
                       'Validation failed: You must scan products to get total price')
  end
end
