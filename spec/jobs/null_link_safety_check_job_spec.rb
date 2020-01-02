# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NullLinkSafetyCheckJob do
  describe 'instance' do
    subject { described_class.new }

    it { is_expected.to respond_to :perform }
  end

  describe 'class' do
    subject { described_class }

    it { is_expected.to respond_to :perform_later }
  end
end
