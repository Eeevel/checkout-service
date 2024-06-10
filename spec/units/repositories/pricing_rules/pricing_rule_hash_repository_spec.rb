# frozen_string_literal: true

require 'money'
require_relative '../../../../lib/repositories/pricing_rules/pricing_rule_hash_repository'
require_relative '../../../../lib/models/pricing_rules/absolute_pricing_rule'

RSpec.describe PricingRuleHashRepository do
  let(:repository) { described_class.new }
  let(:pricing_rule) { AbsolutePricingRule.new('GR1', 2, Money.from_cents(1000, 'GBP')) }

  describe '#create' do
    it 'adds a pricing rule to the repository' do
      repository.create(pricing_rule)
      expect(repository.find_by_code('GR1')).to eq(pricing_rule)
    end
  end

  describe '#find_by_code' do
    it 'returns the pricing rule for the given code' do
      repository.create(pricing_rule)
      expect(repository.find_by_code('GR1')).to eq(pricing_rule)
    end

    it 'returns nil if no pricing rule is found' do
      expect(repository.find_by_code('SR1')).to be_nil
    end
  end

  describe '#all' do
    it 'returns all pricing rules in the repository' do
      repository.create(pricing_rule)
      expect(repository.all).to eq([pricing_rule])
    end

    it 'returns an empty array if no pricing rules are in the repository' do
      expect(repository.all).to eq([])
    end
  end

  describe '#update' do
    let(:updated_pricing_rule) { AbsolutePricingRule.new('GR1', 2, Money.from_cents(1500, 'GBP')) }

    it 'updates the pricing rule for the given code' do
      repository.create(pricing_rule)
      repository.update('GR1', updated_pricing_rule)
      expect(repository.find_by_code('GR1')).to eq(updated_pricing_rule)
    end
  end

  describe '#delete' do
    it 'removes the pricing rule for the given code' do
      repository.create(pricing_rule)
      repository.delete('GR1')
      expect(repository.find_by_code('GR1')).to be_nil
    end
  end
end
