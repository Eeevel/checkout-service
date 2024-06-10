# frozen_string_literal: true

require_relative '../../../lib/errors/validation_error'

RSpec.describe ValidationError do
  describe '#initialize' do
    context 'with errors array' do
      let(:errors) { ["Name can't be blank", 'Email is invalid'] }
      let(:validation_error) { ValidationError.new(errors) }

      it 'sets the errors attribute' do
        expect(validation_error.errors).to eq(errors)
      end

      it 'sets the error message correctly' do
        expected_message = "Validation failed: #{errors.join(', ')}"
        expect(validation_error.message).to eq(expected_message)
      end
    end
  end
end
