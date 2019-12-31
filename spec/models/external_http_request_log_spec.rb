# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalHttpRequestLog, type: :model do
  it 'has the correct model basics', :aggregate_failures do
    is_expected.to have_a_valid_default_factory

    is_expected.to have_attribute :kind
    is_expected.to have_attribute :meta
    is_expected.to have_attribute :response_body
    is_expected.to have_attribute :response_code

    is_expected.to validate_presence_of :kind
    is_expected.to validate_presence_of :response_body
    is_expected.to validate_presence_of :response_code
  end
end
