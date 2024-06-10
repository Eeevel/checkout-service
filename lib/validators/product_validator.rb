# frozen_string_literal: true

require_relative '../errors/validation_error'

class ProductValidator
  class << self
    def validate(code, name, price_cents, currency)
      errors = []

      validate_code(code, errors)
      validate_name(name, errors)
      validate_price_cents(price_cents, errors)
      validate_price_currency(currency, errors)

      raise ValidationError, errors unless errors.empty?
    end

    private

    def validate_code(code, errors)
      return unless !code.is_a?(String) || code.empty?

      errors << 'Code must be a non-empty string'
    end

    def validate_name(name, errors)
      return unless !name.is_a?(String) || name.empty?

      errors << 'Name must be a non-empty string'
    end

    def validate_price_cents(price_cents, errors)
      return unless price_cents.nil? || !price_cents.is_a?(Numeric) || price_cents.negative?

      errors << 'Price must be a positive or zero number'
    end

    def validate_price_currency(currency, errors)
      Money::Currency.new(currency)
    rescue StandardError
      errors << 'Invalid currency'
    end
  end
end
