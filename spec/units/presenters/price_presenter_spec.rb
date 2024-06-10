# frozen_string_literal: true

require 'money'
require_relative '../../../lib/presenters/price_presenter'

RSpec.describe PricePresenter do
  describe '#formatted_price' do
    let(:price) { Money.from_cents(100, 'GBP') }
    let(:presenter) { described_class.new(price) }

    it 'calls format method on the price object' do
      allow(price).to receive(:format)
      presenter.formatted_price
      expect(price).to have_received(:format)
    end
  end
end
