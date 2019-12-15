# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoogleSafeBrowsingApi do
  subject(:api) { described_class.new }

  let(:key) { '123' }

  before do
    allow(ENV).to receive(:[]).with('GOOGLE_SAFE_BROWSING_API_KEY').and_return(key)
  end

  describe '#download_threat_lists' do
    it 'calls the threatList endpoint' do
      stub_request(:get, 'https://safebrowsing.googleapis.com/v4/threatLists?key=123')
        .with(headers: { 'Content-Type' => 'application/json' })
        .to_return(status: 200, body: 'body', headers: {})

      response = api.download_threat_lists
      expect(response.body).to eq 'body'
    end
  end

  describe '#lookup_url(url)' do
    context 'when the request fails' do
      it 'raises a LookupURLFailedError' do
        url = 'http://www.example.com'
        stub_lookup_request(url: url, return_code: 400)

        expect do
          api.lookup_url(url)
        end.to raise_error(GoogleSafeBrowsingApi::LookupURLFailedError)
      end
    end

    context 'when no threat is found' do
      it 'returns an object with safe?=true' do
        url = 'http://www.example.com'
        stub_lookup_request(url: url, return_body: "{}\n")

        response = api.lookup_url(url)
        expect(response.safe?).to be true
      end
    end

    context 'when a threat is found' do
      it 'returns an object with safe?=false' do
        url = 'http://www.example.com'
        stub_lookup_request(url: url, return_body: 'anything-except-an-empty-json-object')

        response = api.lookup_url(url)
        expect(response.safe?).to be false
      end
    end

    it 'includes the status code' do
      url = 'http://www.example.com'
      return_code = 200
      stub_lookup_request(url: url, return_code: return_code)

      response = api.lookup_url(url)
      expect(response.code).to be return_code
    end

    it 'includes the response body' do
      url = 'http://www.example.com'
      body = "{}\n"
      stub_lookup_request(url: url, return_body: body)

      response = api.lookup_url(url)
      expect(response.body).to eq body
    end

    it 'includes the tested url' do
      url = 'http://www.example.com'
      body = "{}\n"
      stub_lookup_request(url: url, return_body: body)

      response = api.lookup_url(url)
      expect(response.url_tested).to eq url
    end

    # rubocop:disable Metrics/MethodLength,Style/WordArray
    def stub_lookup_request(url: 'http://www.example.com', return_code: 200, return_body: 'body')
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
          status: return_code,
          body: return_body,
          headers: {}
        )
    end
    # rubocop:enable Metrics/MethodLength,Style/WordArray
  end
end
