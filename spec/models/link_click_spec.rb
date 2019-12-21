# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkClick, type: :model do
  it { is_expected.to have_attribute :host }

  it { is_expected.to have_attribute :user_agent }

  it { is_expected.to have_attribute :anonymized_ip }

  it { is_expected.to have_attribute :referer }

  it { is_expected.to validate_presence_of :host }

  it { is_expected.to validate_presence_of :user_agent }

  it { is_expected.to validate_presence_of :anonymized_ip }

  it { is_expected.to belong_to :link }

  it 'has a valid factory' do
    expect(build(:link_click)).to be_valid
  end
end
