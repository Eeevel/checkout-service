# frozen_string_literal: true

require_relative '../../../lib/validators/checkout_service_validator'
require_relative '../../../lib/errors/validation_error'
require_relative '../../../lib/repositories/pricing_rules/pricing_rule_repository'
require_relative '../../../lib/repositories/products/product_repository'
require_relative '../../../lib/models/basket'

RSpec.describe CheckoutServiceValidator do
  describe '.validate_initializer' do
    let(:pricing_rule_repository) { PricingRuleRepository.new }
    let(:product_repository) { ProductRepository.new }

    context 'with valid repositories' do
      it 'does not raise an error' do
        expect { described_class.validate_initializer(pricing_rule_repository, product_repository) }.not_to raise_error
      end
    end

    context 'with invalid repositories' do
      it 'raises an error if pricing_rule_repository is not an instance of PricingRuleRepository' do
        expect do
          described_class.validate_initializer('invalid',
                                               product_repository)
        end.to raise_error(ValidationError,
                           'Validation failed: Pricing rule repository must be an instance of PricingRuleRepository class')
      end

      it 'raises an error if product_repository is not an instance of ProductRepository' do
        expect do
          described_class.validate_initializer(pricing_rule_repository,
                                               'invalid')
        end.to raise_error(ValidationError,
                           'Validation failed: Product repository must be an instance of ProductRepository class')
      end
    end
  end

  describe '.validate_basket' do
    let(:basket) { Basket.new }

    context 'with a valid basket' do
      it 'does not raise an error' do
        expect { described_class.validate_basket(basket) }.not_to raise_error
      end
    end

    context 'with an invalid basket' do
      it 'raises an error if basket is not an instance of Basket' do
        expect do
          described_class.validate_basket('invalid')
        end.to raise_error(ValidationError,
                           'Validation failed: Basket must be an instance of Basket class')
      end
    end
  end
end
