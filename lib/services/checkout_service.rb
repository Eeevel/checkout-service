# frozen_string_literal: true

require_relative '../../lib/models/checkout'
require_relative '../validators/checkout_service_validator'

class CheckoutService
  def initialize(pricing_rule_repository, product_repository)
    CheckoutServiceValidator.validate_initializer(pricing_rule_repository, product_repository)

    @pricing_rule_repository = pricing_rule_repository
    @product_repository = product_repository
  end

  def checkout(basket)
    CheckoutServiceValidator.validate_basket(basket)

    checkout = Checkout.new(pricing_rule_repository.all)

    basket.product_codes.each do |product_code|
      product = product_repository.find_by_code(product_code)
      checkout.scan(product)
    end

    checkout.total
  end

  private

  attr_reader :pricing_rule_repository, :product_repository
end
