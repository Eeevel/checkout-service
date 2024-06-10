# frozen_string_literal: true

require 'money'
require './lib/repositories/pricing_rules/pricing_rule_hash_repository'
require './lib/repositories/products/product_hash_repository'
require './lib/models/pricing_rules/absolute_pricing_rule'
require './lib/models/pricing_rules/percentage_pricing_rule'
require './lib/models/pricing_rules/bonus_product_pricing_rule'
require './lib/models/product'
require './lib/models/basket'
require './lib/services/checkout_service'
require './lib/presenters/price_presenter'

I18n.config.available_locales = :en
Money.locale_backend = :i18n
Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN

pricing_rule_repository = PricingRuleHashRepository.new
pricing_rule_repository.create(AbsolutePricingRule.new('SR1', 3, Money.from_cents(450, 'GBP')))
pricing_rule_repository.create(PercentagePricingRule.new('CF1', 3, (1 - Rational(2, 3)) * 100))
pricing_rule_repository.create(BonusProductPricingRule.new('GR1', 1))

product_repository = ProductHashRepository.new
product_repository.create(Product.new('GR1', 'Green tea', 311, 'GBP'))
product_repository.create(Product.new('SR1', 'Strawberries', 500, 'GBP'))
product_repository.create(Product.new('CF1', 'Coffee', 1123, 'GBP'))

checkout_service = CheckoutService.new(pricing_rule_repository, product_repository)

# Basket GR1, SR1, GR1, GR1, CF1
basket = Basket.new
basket.add_item('GR1')
basket.add_item('SR1')
basket.add_item('GR1')
basket.add_item('GR1')
basket.add_item('CF1')
result = checkout_service.checkout(basket)
puts "Result for Basket GR1, SR1, GR1, GR1, CF1 is #{PricePresenter.new(result).formatted_price}"

# Basket GR1, GR1
basket = Basket.new
basket.add_item('GR1')
basket.add_item('GR1')
result = checkout_service.checkout(basket)
puts "Result for Basket GR1, GR1 is #{PricePresenter.new(result).formatted_price}"

# Basket SR1, SR1, GR1, SR1
basket = Basket.new
basket.add_item('SR1')
basket.add_item('SR1')
basket.add_item('GR1')
basket.add_item('SR1')
result = checkout_service.checkout(basket)
puts "Result for Basket SR1, SR1, GR1, SR1 is #{PricePresenter.new(result).formatted_price}"

# Basket GR1, CF1, SR1, CF1, CF1
basket = Basket.new
basket.add_item('GR1')
basket.add_item('CF1')
basket.add_item('SR1')
basket.add_item('CF1')
basket.add_item('CF1')
result = checkout_service.checkout(basket)
puts "Result for Basket GR1, CF1, SR1, CF1, CF1 is #{PricePresenter.new(result).formatted_price}"

#
# co = Checkout.new(pricing_rules)
# basket = Basket.new(co)
# basket.add_item("GR1")
# basket.add_item("GR1")
# puts "Total price expected: £#{basket.total_price}" # Expected output: £3.11
#
# co = Checkout.new(pricing_rules)
# basket = Basket.new(co)
# basket.add_item("SR1")
# basket.add_item("SR1")
# basket.add_item("GR1")
# basket.add_item("SR1")
# puts "Total price expected: £#{basket.total_price}" # Expected output: £16.61
#
# co = Checkout.new(pricing_rules)
# basket = Basket.new(co)
# basket.add_item("GR1")
# basket.add_item("CF1")
# basket.add_item("SR1")
# basket.add_item("CF1")
# basket.add_item("CF1")
# puts "Total price expected: £#{basket.total_price}" # Expected output: £30.57
