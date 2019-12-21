# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkClick, type: :model do
  it { is_expected.to have_attribute :host }

  it { is_expected.to have_attribute :user_agent }

  it { is_expected.to have_attribute :anonymized_ip }

  it { is_expected.to have_attribute :referer }

  it { is_expected.to have_attribute :device_family }

  it { is_expected.to have_attribute :device_model }

  it { is_expected.to have_attribute :device_brand }

  it { is_expected.to have_attribute :os_family }

  it { is_expected.to have_attribute :os_version }

  it { is_expected.to have_attribute :user_agent_family }

  it { is_expected.to have_attribute :user_agent_version }

  it { is_expected.to validate_presence_of :host }

  it { is_expected.to validate_presence_of :user_agent }

  it { is_expected.to validate_presence_of :anonymized_ip }

  it { is_expected.to belong_to :link }

  it 'has a valid factory' do
    expect(build(:link_click)).to be_valid
  end
end
