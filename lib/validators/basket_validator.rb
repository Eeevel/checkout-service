# frozen_string_literal: true

require_relative '../errors/validation_error'

class BasketValidator
  class << self
    def validate(code)
      errors = []

      validate_code(code, errors)

      raise ValidationError, errors unless errors.empty?
    end

    private

    def validate_code(code, errors)
      return unless !code.is_a?(String) || code.empty?

      errors << 'Code must be a non-empty string'
    end
  end
end
