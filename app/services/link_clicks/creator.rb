# frozen_string_literal: true

# Code related to LinkClick
module LinkClicks
  # Creates a LinkClick
  class Creator
    attr_reader :user_agent_parser, :location_provider

    def initialize(
      user_agent_parser: UserAgentParser,
      location_provider: APIs::IpWhoIsAPI.new
    )
      @user_agent_parser = user_agent_parser
      @location_provider = location_provider
    end

    def create(link:, request_data:)
      LinkClick.create!(
        link: link,
        **_request_data_attrs(request_data),
        **_ip_attrs(request_data[:remote_ip]),
        **_user_agent_attrs(request_data[:user_agent])
      )
    end

    private

    def _request_data_attrs(request_data)
      attr_names = LinkClick.attribute_names.map(&:to_sym)
      request_data.slice(*attr_names)
    end

    def _ip_attrs(remote_ip)
      {
        anonymized_ip: _anonymize(remote_ip),
        **location_provider.get_location_data(remote_ip)
      }
    end

    def _anonymize(ip)
      ip&.sub(/\w*\z/, 'X')
    end

    def _user_agent_attrs(user_agent)
      parsed_agent = user_agent_parser.parse(user_agent)

      {
        device_family: parsed_agent.device.family,
        device_model: parsed_agent.device.model,
        device_brand: parsed_agent.device.brand,
        os_family: parsed_agent.os.family,
        os_version: parsed_agent.os.version,
        user_agent_family: parsed_agent.family,
        user_agent_version: parsed_agent.version
      }
    end
  end
end
