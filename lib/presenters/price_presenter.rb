# frozen_string_literal: true

class PricePresenter
  def initialize(price)
    @price = price
  end

  def formatted_price
    price.format
  end

  private

  attr_reader :price
end
