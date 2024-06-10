# frozen_string_literal: true

class ProductRepository
  def create(_product)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def find_by_code(_code)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def all
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def update(_code, _product)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def delete(_code)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  private

  attr_accessor :products
end
