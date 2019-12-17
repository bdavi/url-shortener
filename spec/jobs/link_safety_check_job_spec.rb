# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkSafetyCheckJob, type: :job do
  subject(:job) { described_class.new }

  describe '#perform' do
    context 'when the check passes' do
      it 'sets the link status to approved' do
        link = build(:link, :pending)
        api = instance_double('GoogleSafeBrowsingApi', url_is_safe?: true)

        job.perform(link, api: api)

        expect(link.reload).to be_approved
      end
    end

    context 'when the check fails' do
      it 'sets the link status to failed_safety_check' do
        link = build(:link, :pending)
        api = instance_double('GoogleSafeBrowsingApi', url_is_safe?: false)

        job.perform(link, api: api)

        expect(link.reload).to be_failed_safety_check
      end
    end
  end
end
