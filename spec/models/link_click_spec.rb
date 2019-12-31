# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkClick, type: :model do
  # rubocop:disable RSpec/ExampleLength
  it 'has the correct model basics', :aggregate_failures do
    is_expected.to have_a_valid_default_factory

    is_expected.to have_attribute :anonymized_ip
    is_expected.to have_attribute :city
    is_expected.to have_attribute :clicked_at
    is_expected.to have_attribute :country
    is_expected.to have_attribute :device_brand
    is_expected.to have_attribute :device_family
    is_expected.to have_attribute :device_model
    is_expected.to have_attribute :host
    is_expected.to have_attribute :isp
    is_expected.to have_attribute :latitude
    is_expected.to have_attribute :longitude
    is_expected.to have_attribute :os_family
    is_expected.to have_attribute :os_version
    is_expected.to have_attribute :referer
    is_expected.to have_attribute :region
    is_expected.to have_attribute :timezone
    is_expected.to have_attribute :timezone_name
    is_expected.to have_attribute :user_agent
    is_expected.to have_attribute :user_agent_family
    is_expected.to have_attribute :user_agent_version

    is_expected.to validate_presence_of :anonymized_ip
    is_expected.to validate_presence_of :clicked_at
    is_expected.to validate_presence_of :host
    is_expected.to validate_presence_of :user_agent

    is_expected.to belong_to :link
  end
  # rubocop:enable RSpec/ExampleLength
end
