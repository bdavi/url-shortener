# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkClick, type: :model do
  # rubocop:disable RSpec/ExampleLength
  it :aggregate_failures do
    is_expected.to have_a_valid_default_factory

    is_expected.to have_db_column :anonymized_ip
    is_expected.to have_db_column :city
    is_expected.to have_db_column :clicked_at
    is_expected.to have_db_column :country
    is_expected.to have_db_column :device_brand
    is_expected.to have_db_column :device_family
    is_expected.to have_db_column :device_model
    is_expected.to have_db_column :host
    is_expected.to have_db_column :isp
    is_expected.to have_db_column :latitude
    is_expected.to have_db_column :longitude
    is_expected.to have_db_column :os_family
    is_expected.to have_db_column :os_version
    is_expected.to have_db_column :referer
    is_expected.to have_db_column :region
    is_expected.to have_db_column :timezone
    is_expected.to have_db_column :timezone_name
    is_expected.to have_db_column :user_agent
    is_expected.to have_db_column :user_agent_family
    is_expected.to have_db_column :user_agent_version

    is_expected.to validate_presence_of :anonymized_ip
    is_expected.to validate_presence_of :clicked_at
    is_expected.to validate_presence_of :host
    is_expected.to validate_presence_of :user_agent

    is_expected.to belong_to :link
  end
  # rubocop:enable RSpec/ExampleLength
end
