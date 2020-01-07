# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/ExampleLength
RSpec.describe LinkClicks::Creator, type: :service do
  subject(:creator) do
    location_provider = instance_double('IpWhoIsApi', get_location_data: {})
    described_class.new(location_provider: location_provider)
  end

  let(:link) { create(:link) }

  describe '#create' do
    it 'creates a LinkClick with the correct attributes' do
      clicked_at = DateTime.now
      agent = 'Mozilla/5.0 (iPad; CPU OS 10_2_1 like Mac OS X) AppleWebKit/600.1.4' \
                ' (KHTML, like Gecko) GSA/23.1.148956103 Mobile/14D27 Safari/600.1.4'
      remote_ip = '73.243.86.12'
      env_data = {
        'HTTP_HOST' => 'some-random-host',
        'HTTP_USER_AGENT' => agent,
        'HTTP_REFERER' => 'referer'
      }
      location_data = {
        'country' => 'United States',
        'region' => 'Colorado',
        'city' => 'Denver',
        'latitude' => '39.7392358',
        'longitude' => '-104.990251',
        'isp' => 'Comcast Cable Communications, LLC',
        'timezone' => 'America/Denver',
        'timezone_name' => 'Mountain Standard Time'
      }
      location_provider = instance_double('IpWhoIsApi', get_location_data: location_data)
      creator = described_class.new(location_provider: location_provider)

      click = creator.create(
        link: link,
        env_data: env_data,
        clicked_at: clicked_at,
        remote_ip: remote_ip
      )

      expect(click).to have_attributes(
        host: 'some-random-host',
        user_agent: agent,
        referer: 'referer',
        link_id: link.id,
        anonymized_ip: '73.243.86.X',
        device_family: 'iPad',
        device_model: 'iPad',
        device_brand: 'Apple',
        os_family: 'iOS',
        os_version: '10.2.1',
        user_agent_family: 'Google',
        user_agent_version: '23.1.148956103',
        country: 'United States',
        region: 'Colorado',
        city: 'Denver',
        latitude: 0.397392358e2,
        longitude: -0.104990251e3,
        isp: 'Comcast Cable Communications, LLC',
        timezone: 'America/Denver',
        timezone_name: 'Mountain Standard Time',
        clicked_at: clicked_at
      )
      expect(click).to be_persisted
    end

    it 'anonymizes IPv6 addresses' do
      env_data = {
        'HTTP_HOST' => 'v6-host',
        'HTTP_USER_AGENT' => 'agent',
        'HTTP_REFERER' => 'referer'
      }
      remote_ip = '2001::3238:DFE1:63:0000:0000:FEFB'

      click = creator.create(
        link: link,
        env_data: env_data,
        clicked_at: DateTime.now,
        remote_ip: remote_ip
      )

      expect(click.anonymized_ip).to eq '2001::3238:DFE1:63:0000:0000:X'
    end

    context 'when referrer is an empty string' do
      it 'stores nil as the referer' do
        env_data = {
          'HTTP_HOST' => 'referer-host',
          'HTTP_USER_AGENT' => 'agent',
          'HTTP_REFERER' => '',
          'REMOTE_ADDR' => '2001::3238:DFE1:63:0000:0000:FEFB'
        }

        click = creator.create(
          link: link,
          env_data: env_data,
          clicked_at: DateTime.now,
          remote_ip: 'ip'
        )

        expect(click.referer).to be_nil
      end
    end

    context 'when the env data is invalid' do
      it 'raises an error' do
        env_data = {
          'HTTP_REFERER' => '',
          'REMOTE_ADDR' => '2001::3238:DFE1:63:0000:0000:FEFB'
        }

        expect do
          creator.create(
            link: link,
            env_data: env_data,
            clicked_at: DateTime.now,
            remote_ip: 'ip'
          )
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
# rubocop:enable RSpec/ExampleLength
