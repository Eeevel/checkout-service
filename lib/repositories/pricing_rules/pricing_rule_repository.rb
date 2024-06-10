# frozen_string_literal: true

class PricingRuleRepository
  def create(_pricing_rule)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def find_by_code(_code)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def all
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def update(_code, _pricing_rule)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def delete(_code)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  private

  attr_accessor :pricing_rules
end
