# frozen_string_literal: true

class PricingRule
  attr_reader :required_product_code, :required_count

  def can_handle?(_product_code)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def calculate(_products)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
