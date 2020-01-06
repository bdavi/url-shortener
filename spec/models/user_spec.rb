# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # rubocop:disable RSpec/ExampleLength
  it 'has the correct model basics', :aggregate_failures do
    is_expected.to have_a_valid_default_factory

    is_expected.to have_attribute :confirmation_sent_at
    is_expected.to have_attribute :confirmation_token
    is_expected.to have_attribute :confirmed_at
    is_expected.to have_attribute :current_sign_in_at
    is_expected.to have_attribute :current_sign_in_ip
    is_expected.to have_attribute :email
    is_expected.to have_attribute :encrypted_password
    is_expected.to have_attribute :failed_attempts
    is_expected.to have_attribute :last_sign_in_at
    is_expected.to have_attribute :last_sign_in_ip
    is_expected.to have_attribute :locked_at
    is_expected.to have_attribute :remember_created_at
    is_expected.to have_attribute :reset_password_sent_at
    is_expected.to have_attribute :reset_password_token
    is_expected.to have_attribute :sign_in_count
    is_expected.to have_attribute :unconfirmed_email
    is_expected.to have_attribute :unlock_token

    is_expected.to validate_presence_of :email
    is_expected.to validate_the_uniqueness_of :email
  end
  # rubocop:enable RSpec/ExampleLength
end
