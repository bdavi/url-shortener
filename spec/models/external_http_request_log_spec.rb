# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalHttpRequestLog, type: :model do
  it { is_expected.to have_attribute :kind }

  it { is_expected.to have_attribute :meta }

  it { is_expected.to have_attribute :response_body }

  it { is_expected.to have_attribute :response_code }

  it { is_expected.to validate_presence_of :kind }

  it { is_expected.to validate_presence_of :response_body }

  it { is_expected.to validate_presence_of :response_code }

  it 'has a valid factory' do
    expect(build(:external_http_request_log)).to be_valid
  end
end
