# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # rubocop:disable RSpec/ExampleLength
  it :aggregate_failures do
    is_expected.to have_a_valid_default_factory

    is_expected.to have_db_column :confirmation_sent_at
    is_expected.to have_db_column :confirmation_token
    is_expected.to have_db_column :confirmed_at
    is_expected.to have_db_column :current_sign_in_at
    is_expected.to have_db_column :current_sign_in_ip
    is_expected.to have_db_column :email
    is_expected.to have_db_column :encrypted_password
    is_expected.to have_db_column :failed_attempts
    is_expected.to have_db_column :last_sign_in_at
    is_expected.to have_db_column :last_sign_in_ip
    is_expected.to have_db_column :locked_at
    is_expected.to have_db_column :remember_created_at
    is_expected.to have_db_column :reset_password_sent_at
    is_expected.to have_db_column :reset_password_token
    is_expected.to have_db_column :sign_in_count
    is_expected.to have_db_column :unconfirmed_email
    is_expected.to have_db_column :unlock_token

    is_expected.to validate_presence_of :email
    is_expected.to validate_the_uniqueness_of :email
  end
  # rubocop:enable RSpec/ExampleLength
end
