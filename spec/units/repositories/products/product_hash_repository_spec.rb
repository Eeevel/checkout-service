# frozen_string_literal: true

require 'money'
require_relative '../../../../lib/repositories/products/product_hash_repository'
require_relative '../../../../lib/models/product'

RSpec.describe ProductHashRepository do
  let(:repository) { described_class.new }
  let(:product) { Product.new('GR1', 'Product 1', 100, 'GBP') }

  describe '#create' do
    it 'adds a product to the repository' do
      repository.create(product)
      expect(repository.find_by_code('GR1')).to eq(product)
    end
  end

  describe '#find_by_code' do
    it 'returns the product for the given code' do
      repository.create(product)
      expect(repository.find_by_code('GR1')).to eq(product)
    end

    it 'returns nil if no product is found' do
      expect(repository.find_by_code('SR1')).to be_nil
    end
  end

  describe '#all' do
    it 'returns all products in the repository' do
      repository.create(product)
      expect(repository.all).to eq([product])
    end

    it 'returns an empty array if no products are in the repository' do
      expect(repository.all).to eq([])
    end
  end

  describe '#update' do
    let(:updated_product) { Product.new('GR1', 'Updated Product', 150, 'GBP') }

    it 'updates the product for the given code' do
      repository.create(product)
      repository.update('GR1', updated_product)
      expect(repository.find_by_code('GR1')).to eq(updated_product)
    end
  end

  describe '#delete' do
    it 'removes the product for the given code' do
      repository.create(product)
      repository.delete('GR1')
      expect(repository.find_by_code('GR1')).to be_nil
    end
  end
end
