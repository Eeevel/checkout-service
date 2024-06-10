# frozen_string_literal: true

require_relative '../../../../lib/repositories/pricing_rules/pricing_rule_repository'

RSpec.describe PricingRuleRepository do
  describe '#create' do
    it 'raises a NotImplementedError' do
      expect do
        subject.create(double('PricingRule'))
      end.to raise_error(NotImplementedError,
                         "PricingRuleRepository has not implemented method 'create'")
    end
  end

  describe '#find_by_code' do
    it 'raises a NotImplementedError' do
      expect do
        subject.find_by_code('code')
      end.to raise_error(NotImplementedError,
                         "PricingRuleRepository has not implemented method 'find_by_code'")
    end
  end

  describe '#all' do
    it 'raises a NotImplementedError' do
      expect do
        subject.all
      end.to raise_error(NotImplementedError, "PricingRuleRepository has not implemented method 'all'")
    end
  end

  describe '#update' do
    it 'raises a NotImplementedError' do
      expect do
        subject.update('code',
                       double('PricingRule'))
      end.to raise_error(NotImplementedError, "PricingRuleRepository has not implemented method 'update'")
    end
  end

  describe '#delete' do
    it 'raises a NotImplementedError' do
      expect do
        subject.delete('code')
      end.to raise_error(NotImplementedError,
                         "PricingRuleRepository has not implemented method 'delete'")
    end
  end
end
