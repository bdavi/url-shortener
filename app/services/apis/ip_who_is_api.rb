# frozen_string_literal: true

# External APIs
module APIs
  # Wraps the ipwhois.io api
  # See the docs at https://ipwhois.io/documentation
  class IpWhoIsAPI
    ENDPOINT_BASE_URL = 'http://free.ipwhois.io/json/'

    LOCATION_DATA_KEYS = %w[
      country
      region
      city
      isp
      latitude
      longitude
      timezone
      timezone_name
    ].freeze

    attr_reader :response, :ip_address, :logger

    # Use NullExternalRequestLogger if you don't want to log requests
    def initialize(logger: APIs::ExternalRequestLogger.new)
      @logger = logger
    end

    def get_location_data(ip_address)
      lookup_ip_address(ip_address)
      _parsed_response_body.slice(*LOCATION_DATA_KEYS)
    end

    def lookup_ip_address(ip_address)
      @ip_address = ip_address
      @response = HTTParty.get(_endpoint_url)

      _log_request
      _raise_error_if_failed
    end

    private

    def _parsed_response_body
      JSON.parse(response.body)
    end

    def _log_request
      logger.log(
        kind: 'IpWhoIsApi#lookup_ip_address',
        meta: { ip_address: ip_address },
        response_body: response.body,
        response_code: response.code
      )
    end

    def _endpoint_url
      ENDPOINT_BASE_URL + ip_address
    end

    def _raise_error_if_failed
      raise HttpRequestFailedError if _http_request_failed?
      raise InvalidIpAddressError if _ip_address_is_invalid?
      raise MonthlyLimitHitError if _hit_monthly_limit?
    end

    def _http_request_failed?
      response.code < 200 || response.code >= 300
    end

    def _ip_address_is_invalid?
      _parsed_response_body['message'] == 'invalid ip address'
    end

    def _hit_monthly_limit?
      _parsed_response_body['message'] == "you've hit the monthly limit"
    end

    # Raised if response code is not 2XX
    class HttpRequestFailedError < StandardError; end

    # Raised when trying to lookup an invalid ip address
    class InvalidIpAddressError < StandardError; end

    # Raised when the monthly API call limit is met.
    # Does not mean there is a problem with the IP address.
    class MonthlyLimitHitError < StandardError; end
  end
end
