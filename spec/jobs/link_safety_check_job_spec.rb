# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkSafetyCheckJob, type: :job do
  subject(:job) { described_class.new }

  describe '#perform' do
    context 'when the check passes' do
      it 'sets the link status to approved' do
        link = build(:link, :pending)
        lookup_result = OpenStruct.new(safe?: true)
        url_checker = instance_double('GoogleSafeBrowsingApi', lookup_url: lookup_result)

        job.perform(link, url_checker: url_checker)
        expect(link.reload).to be_approved
      end
    end

    context 'when the check fails' do
      it 'sets the link status to failed_safety_check' do
        link = build(:link, :pending)
        lookup_result = OpenStruct.new(safe?: false)
        url_checker = instance_double('GoogleSafeBrowsingApi', lookup_url: lookup_result)

        job.perform(link, url_checker: url_checker)
        expect(link.reload).to be_failed_safety_check
      end
    end

    it 'records the results of the check in ExternalHttpRequestLog' do
      link = build(:link, :pending)
      lookup_result = OpenStruct.new(safe?: true, body: "{}\n", code: 200, url_tested: link.url)
      url_checker = instance_double('GoogleSafeBrowsingApi', lookup_url: lookup_result)

      job.perform(link, url_checker: url_checker)
      log = ExternalHttpRequestLog.find_by("meta->>'url_tested' = ?", link.url)

      expect(log).to have_attributes(
        response_code: 200,
        response_body: "{}\n",
        kind: 'GoogleSafeBrowsingApi#lookup_url'
      )
    end
  end
end
