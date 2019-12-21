# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IpWhoIsApi do
  subject(:api) { described_class.new }

  describe '#lookup_ip_address(ip_address)' do
    it 'sets the ip_addresss' do
      ip_address = '50.246.198.147'
      stub_lookup_request(ip_address: ip_address)

      api.lookup_ip_address(ip_address)

      expect(api.ip_address).to eq ip_address
    end

    it 'does the request and sets the response' do
      ip_address = '50.246.198.147'
      stub_lookup_request(ip_address: ip_address, response_body: '{}', response_code: 201)

      api.lookup_ip_address(ip_address)

      expect(api.response.body).to eq '{}'
      expect(api.response.code).to eq 201
    end

    context 'when the http request fails' do
      it 'raises a HttpRequestFailedError' do
        ip_address = '50.246.198.147'
        stub_lookup_request(ip_address: ip_address, response_code: 422)

        expect do
          api.lookup_ip_address(ip_address)
        end.to raise_error(described_class::HttpRequestFailedError)
      end
    end

    context 'when the ip_address is invalid' do
      it 'raises a InvalidIpAddressError' do
        ip_address = 'not-an-ip-address'
        body = { 'message' => 'invalid ip address' }.to_json
        stub_lookup_request(ip_address: ip_address, response_body: body, response_code: 200)

        expect do
          api.lookup_ip_address(ip_address)
        end.to raise_error(described_class::InvalidIpAddressError)
      end
    end

    context 'when the monthly api call limit has been reached' do
      it 'raises a MonthlyLimitHitError' do
        ip_address = '50.246.198.147'
        body = { 'message' => "you've hit the monthly limit" }.to_json
        stub_lookup_request(ip_address: ip_address, response_body: body, response_code: 200)

        expect do
          api.lookup_ip_address(ip_address)
        end.to raise_error(described_class::MonthlyLimitHitError)
      end
    end

    it 'logs the request' do
      ip_address = '50.246.198.147'
      stub_lookup_request(ip_address: ip_address, response_body: '{}', response_code: 201)

      expect(api.logger).to receive(:log).with(
        kind: 'IpWhoIsApi#lookup_ip_address',
        meta: { ip_address: ip_address },
        response_code: 201,
        response_body: '{}'
      )

      api.lookup_ip_address(ip_address)
    end
  end

  describe '#get_location_data(ip_address)' do
    # rubocop:disable RSpec/ExampleLength
    it 'returns a subset of the response as a hash' do
      body = {
        'ip' => '50.246.198.147',
        'success' => true,
        'type' => 'IPv4',
        'continent' => 'North America',
        'continent_code' => 'NA',
        'country' => 'United States',
        'country_code' => 'US',
        'country_flag' => 'https://cdn.ipwhois.io/flags/us.svg',
        'country_capital' => 'Washington',
        'country_phone' => '+1',
        'country_neighbours' => 'CA,MX,CU',
        'region' => 'Colorado',
        'city' => 'Denver',
        'latitude' => '39.7392358',
        'longitude' => '-104.990251',
        'asn' => 'AS7922',
        'org' => 'Comcast Cable Communications, LLC',
        'isp' => 'Comcast Cable Communications, LLC',
        'timezone' => 'America/Denver',
        'timezone_name' => 'Mountain Standard Time',
        'timezone_dstOffset' => '0',
        'timezone_gmtOffset' => '-25200',
        'timezone_gmt' => 'GMT -7:00',
        'currency' => 'US Dollar',
        'currency_code' => 'USD',
        'currency_symbol' => '$',
        'currency_rates' => '1',
        'currency_plural' => 'US dollars',
        'completed_requests' => 0
      }.to_json

      ip_address = '50.246.198.147'
      stub_lookup_request(ip_address: ip_address, response_body: body, response_code: 200)

      expected = {
        'country' => 'United States',
        'region' => 'Colorado',
        'city' => 'Denver',
        'latitude' => '39.7392358',
        'longitude' => '-104.990251',
        'isp' => 'Comcast Cable Communications, LLC',
        'timezone' => 'America/Denver',
        'timezone_name' => 'Mountain Standard Time'
      }

      expect(api.get_location_data(ip_address)).to eq expected
    end
    # rubocop:enable RSpec/ExampleLength
  end

  def stub_lookup_request(ip_address: '50.246.198.147', response_code: 200, response_body: '{}')
    stub_request(:get, "http://free.ipwhois.io/json/#{ip_address}")
      .to_return(
        status: response_code,
        body: response_body,
        headers: {}
      )
  end
end
