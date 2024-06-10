# frozen_string_literal: true

require_relative 'product_repository'

class ProductHashRepository < ProductRepository
  def initialize
    @products = {}
  end

  def create(product)
    products[product.code] = product
  end

  def find_by_code(code)
    products[code]
  end

  def all
    products.values
  end

  def update(code, product)
    products[code] = product
  end

  def delete(code)
    products.delete(code)
  end
end
