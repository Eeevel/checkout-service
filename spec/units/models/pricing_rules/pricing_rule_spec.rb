# frozen_string_literal: true

require_relative '../../../../lib/models/pricing_rules/pricing_rule'

RSpec.describe PricingRule do
  describe '#can_handle?' do
    it 'raises NotImplementedError' do
      pricing_rule = described_class.new
      expect do
        pricing_rule.can_handle?('GR1')
      end.to raise_error(NotImplementedError,
                         "PricingRule has not implemented method 'can_handle?'")
    end
  end

  describe '#calculate' do
    it 'raises NotImplementedError' do
      pricing_rule = described_class.new
      expect do
        pricing_rule.calculate([])
      end.to raise_error(NotImplementedError, "PricingRule has not implemented method 'calculate'")
    end
  end
end
