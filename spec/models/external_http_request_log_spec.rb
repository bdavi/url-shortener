# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalHttpRequestLog, type: :model do
  it 'has the correct attributes', :aggregate_failures do
    is_expected.to have_attribute :kind
    is_expected.to have_attribute :meta
    is_expected.to have_attribute :response_body
    is_expected.to have_attribute :response_code
  end

  it 'has the correct validations', :aggregate_failures do
    is_expected.to validate_presence_of :kind
    is_expected.to validate_presence_of :response_body
    is_expected.to validate_presence_of :response_code
  end

  it 'has a valid factory' do
    expect(build(:external_http_request_log)).to be_valid
  end
end
