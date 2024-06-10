# frozen_string_literal: true

require 'money'
require_relative '../../../../lib/repositories/products/product_repository'
require_relative '../../../../lib/models/product'

RSpec.describe ProductRepository do
  describe '#create' do
    it 'raises a NotImplementedError' do
      expect do
        subject.create(Product.new('GR1', 'Product 1', 100,
                                   'GBP'))
      end.to raise_error(NotImplementedError, "ProductRepository has not implemented method 'create'")
    end
  end

  describe '#find_by_code' do
    it 'raises a NotImplementedError' do
      expect do
        subject.find_by_code('code')
      end.to raise_error(NotImplementedError,
                         "ProductRepository has not implemented method 'find_by_code'")
    end
  end

  describe '#all' do
    it 'raises a NotImplementedError' do
      expect { subject.all }.to raise_error(NotImplementedError, "ProductRepository has not implemented method 'all'")
    end
  end

  describe '#update' do
    it 'raises a NotImplementedError' do
      expect do
        subject.update('code',
                       Product.new('GR1', 'Product 1', 100, 'GBP'))
      end.to raise_error(NotImplementedError, "ProductRepository has not implemented method 'update'")
    end
  end

  describe '#delete' do
    it 'raises a NotImplementedError' do
      expect do
        subject.delete('code')
      end.to raise_error(NotImplementedError, "ProductRepository has not implemented method 'delete'")
    end
  end
end
