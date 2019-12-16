# frozen_string_literal: true

# Wraps Google Safe Browsing API V4
# See the docs at https://developers.google.com/safe-browsing/v4
class GoogleSafeBrowsingApi
  BASE_ENDPOINT_URL = 'https://safebrowsing.googleapis.com/v4/threatMatches:find?key='

  HEADERS = { 'Content-Type' => 'application/json' }.freeze

  NO_THREATS_FOUND_RESPONSE_BODY = "{}\n"

  attr_reader :response, :url, :log_requests_made

  def initialize(log_requests_made: true)
    @log_requests_made = log_requests_made
  end

  def url_is_safe?(url)
    lookup_url(url)
    _raise_failure_error if _request_failed?
    _safe?
  end

  def lookup_url(url)
    @url = url
    @response = HTTParty.post(_endpoint_url, headers: HEADERS, body: _request_body)
    _log_lookup_request if log_requests_made
  end

  private

  def _request_failed?
    response.code != 200
  end

  def _log_lookup_request
    ExternalHttpRequestLog.create(
      kind: 'GoogleSafeBrowsingApi#lookup_url',
      meta: {
        url_tested: url,
        safe?: _safe?
      },
      response_body: response.body,
      response_code: response.code
    )
  end

  def _safe?
    response.body == NO_THREATS_FOUND_RESPONSE_BODY
  end

  def _raise_failure_error
    raise LookupURLFailedError, "API returned: #{response.code}"
  end

  def _endpoint_url
    BASE_ENDPOINT_URL + ENV['GOOGLE_SAFE_BROWSING_API_KEY']
  end

  # rubocop:disable Metrics/MethodLength,Style/WordArray
  def _request_body
    {
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
    }.to_json
  end
  # rubocop:enable Metrics/MethodLength,Style/WordArray

  # Raised when request to api fails or does not return 200
  class LookupURLFailedError < StandardError; end
end
