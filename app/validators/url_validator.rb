# frozen_string_literal: true

# Validator which ensures an attribute is a valid url
class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    is_valid = begin
                 URI.parse(value).is_a?(URI::HTTP)
               rescue URI::InvalidURIError
                 false
               end

    return if is_valid

    record.errors[attribute] << 'is an invalid URL'
  end
end
