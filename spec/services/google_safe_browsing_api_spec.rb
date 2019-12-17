# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoogleSafeBrowsingApi do
  subject(:api) { described_class.new }

  let(:key) { '123' }

  before { ENV['GOOGLE_SAFE_BROWSING_API_KEY'] = key }

  describe '#url_is_safe(url)' do
    context 'when the url is safe' do
      it 'returns true' do
        url = 'http://www.test.com'
        stub_lookup_request(url: url, response_body: "{}\n", response_code: 200)

        expect(api.url_is_safe?(url)).to be true
      end
    end

    context 'when the url is not safe' do
      it 'returns false' do
        url = 'http://www.test.com'
        stub_lookup_request(url: url, response_body: 'anything-but-empty-json', response_code: 200)

        expect(api.url_is_safe?(url)).to be false
      end
    end

    context 'when the request does not succeed' do
      it 'returns raises a LookupURLFailedError' do
        url = 'http://www.test.com'
        stub_lookup_request(url: url, response_code: 402)

        expect do
          api.url_is_safe?(url)
        end.to raise_error(described_class::LookupURLFailedError)
      end
    end
  end

  describe '#lookup_url(url)' do
    it 'sets @url' do
      url = 'http://www.test.com'
      stub_lookup_request(url: url)

      api.lookup_url(url)

      expect(api.url).to eq url
    end

    it 'makes the request and sets @response' do
      url = 'http://www.test.com'
      response_body = 'the-response-body'
      stub_lookup_request(url: url, response_body: response_body)

      api.lookup_url(url)

      expect(api.response.body).to eq response_body
    end

    context 'when logging requests' do
      it 'records the response in a ExternalHttpRequestLog' do
        api = described_class.new(should_log_requests: true)
        url = 'http://www.some-unique-url.com'
        stub_lookup_request(url: url, response_body: 'the-body', response_code: 422)

        api.lookup_url(url)

        log = ExternalHttpRequestLog.find_by("meta ->> 'url_tested' = ?", url)
        expect(log).to have_attributes(
          response_code: 422,
          response_body: 'the-body',
          kind: 'GoogleSafeBrowsingApi#lookup_url'
        )
      end
    end

    context 'when not logging requests' do
      it 'does not create a ExternalHttpRequestLog' do
        api = described_class.new(should_log_requests: false)
        url = 'http://www.test.com'
        stub_lookup_request(url: url)

        expect do
          api.lookup_url(url)
        end.not_to change(ExternalHttpRequestLog, :count)
      end
    end
  end

  # rubocop:disable Metrics/MethodLength,Style/WordArray
  def stub_lookup_request(url: 'http://www.example.com', response_code: 200, response_body: 'body')
    stub_request(:post, "https://safebrowsing.googleapis.com/v4/threatMatches:find?key=#{key}")
      .with(
        body: {
          client: {
            clientId: 'url-shortener',
            clientVersion: 'pre-alpha'
          },
          threatInfo: {
            threatTypes: [
              'MALWARE',
              'SOCIAL_ENGINEERING',
              'POTENTIALLY_HARMFUL_APPLICATION',
              'UNWANTED_SOFTWARE'
            ],
            platformTypes: ['ANY_PLATFORM'],
            threatEntryTypes: ['URL'],
            threatEntries: [{ url: url }]
          }
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      .to_return(
        status: response_code,
        body: response_body,
        headers: {}
      )
  end
  # rubocop:enable Metrics/MethodLength,Style/WordArray
end
