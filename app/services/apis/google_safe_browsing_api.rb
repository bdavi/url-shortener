# frozen_string_literal: true

# External APIs
module APIs
  # Wraps Google Safe Browsing API V4
  # See the docs at https://developers.google.com/safe-browsing/v4
  class GoogleSafeBrowsingAPI
    ENDPOINT_BASE_URL = 'https://safebrowsing.googleapis.com/v4/threatMatches:find?key='

    HEADERS = { 'Content-Type' => 'application/json' }.freeze

    NO_THREATS_FOUND_RESPONSE_BODY = "{}\n"

    attr_reader :response, :url, :logger

    # Use NullExternalRequestLogger if you don't want to log requests
    def initialize(logger: APIs::ExternalRequestLogger.new)
      @logger = logger
    end

    def url_is_safe?(url)
      lookup_url(url)
      _safe?
    end

    def lookup_url(url)
      @url = url
      @response = HTTParty.post(_endpoint_url, headers: HEADERS, body: _request_body)

      _log_request
      _raise_failure_error if _request_failed?
    end

    private

    def _log_request
      logger.log(
        kind: 'GoogleSafeBrowsingApi#lookup_url',
        meta: { url_tested: url, safe?: _safe? },
        response_body: response.body,
        response_code: response.code
      )
    end

    def _endpoint_url
      ENDPOINT_BASE_URL + ENV['GOOGLE_SAFE_BROWSING_API_KEY']
    end

    def _request_failed?
      response.code < 200 || response.code >= 300
    end

    def _safe?
      response.body == NO_THREATS_FOUND_RESPONSE_BODY
    end

    def _raise_failure_error
      raise LookupURLFailedError, "API returned: #{response.code}"
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
end
