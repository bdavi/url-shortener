# frozen_string_literal: true

# Wraps Google Safe Browsing API V4
# See the docs at https://developers.google.com/safe-browsing/v4
class GoogleSafeBrowsingApi
  LOOKUP_BASE_URL = 'https://safebrowsing.googleapis.com/v4/threatMatches:find?key='

  THREAT_LIST_BASE_URL = 'https://safebrowsing.googleapis.com/v4/threatLists?key='

  HEADERS = { 'Content-Type' => 'application/json' }.freeze

  NO_THREATS_FOUND_BODY = "{}\n"

  attr_reader :_response, :_url

  def lookup_url(url)
    @_url = url
    @_response = HTTParty.post(_lookup_url, headers: HEADERS, body: _lookup_request_body)

    _raise_lookup_failed_error unless _response.code == 200

    _formatted_response
  end

  def download_threat_lists
    HTTParty.get(_threat_list_url, headers: HEADERS)
  end

  private

  def _formatted_response
    OpenStruct.new(
      body: _response.body,
      code: _response.code,
      safe?: _safe?,
      url_tested: _url
    )
  end

  def _safe?
    _response.body == NO_THREATS_FOUND_BODY
  end

  def _raise_lookup_failed_error
    raise LookupURLFailedError, "API returned: #{_response.code}"
  end

  def _api_key
    ENV['GOOGLE_SAFE_BROWSING_API_KEY']
  end

  def _lookup_url
    LOOKUP_BASE_URL + _api_key
  end

  def _threat_list_url
    THREAT_LIST_BASE_URL + _api_key
  end

  # rubocop:disable Metrics/MethodLength,Style/WordArray
  def _lookup_request_body
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
        threatEntries: [{ url: _url }]
      }
    }.to_json
  end
  # rubocop:enable Metrics/MethodLength,Style/WordArray

  # Raised when request to api fails or does not return 200
  class LookupURLFailedError < StandardError; end
end
