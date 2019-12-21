# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClickRecorder, type: :service do
  subject(:recorder) { described_class.new }

  let(:link) { create(:link) }

  describe '#record_click' do
    # rubocop:disable RSpec/ExampleLength
    it 'creates a LinkClick with the correct attributes' do
      agent = 'Mozilla/5.0 (iPad; CPU OS 10_2_1 like Mac OS X) AppleWebKit/600.1.4' \
                ' (KHTML, like Gecko) GSA/23.1.148956103 Mobile/14D27 Safari/600.1.4'

      env_data = {
        'HTTP_HOST' => 'some-random-host',
        'HTTP_USER_AGENT' => agent,
        'HTTP_REFERER' => 'referer',
        'REMOTE_ADDR' => '73.243.86.12'
      }

      click = recorder.record_click(link, env_data)

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
        user_agent_version: '23.1.148956103'
      )
      expect(click).to be_persisted
    end
    # rubocop:enable RSpec/ExampleLength

    it 'anonymizes IPv6 addresses' do
      env_data = {
        'HTTP_HOST' => 'v6-host',
        'HTTP_USER_AGENT' => 'agent',
        'HTTP_REFERER' => 'referer',
        'REMOTE_ADDR' => '2001::3238:DFE1:63:0000:0000:FEFB'
      }

      click = recorder.record_click(link, env_data)

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

        click = recorder.record_click(link, env_data)

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
          recorder.record_click(link, env_data)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
