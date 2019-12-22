# frozen_string_literal: true

# Records a link click
class ClickRecorder
  attr_reader :user_agent_parser, :location_provider

  def initialize(
    user_agent_parser: UserAgentParser,
    location_provider: IpWhoIsApi.new
  )
    @user_agent_parser = user_agent_parser
    @location_provider = location_provider
  end

  def record_click(link:, env_data:, clicked_at:)
    click = LinkClick.new(link: link, clicked_at: clicked_at)
    _assign_env_attrs(click, env_data)
    _assign_parsed_user_agent_attrs(click)
    _assign_location_attrs(click, env_data['REMOTE_ADDR'])
    click.save!
    click
  end

  private

  def _assign_location_attrs(click, ip_address)
    location_data = location_provider.get_location_data(ip_address)
    click.assign_attributes(location_data)
  end

  def _assign_env_attrs(click, env_data)
    click.host = env_data['HTTP_HOST']
    click.user_agent = env_data['HTTP_USER_AGENT']
    click.referer = env_data['HTTP_REFERER'].presence
    click.anonymized_ip = _anonymize(env_data['REMOTE_ADDR'])
  end

  def _anonymize(ip)
    ip&.sub(/\w*\z/, 'X')
  end

  # rubocop:disable Metrics/AbcSize
  def _assign_parsed_user_agent_attrs(click)
    agent = user_agent_parser.parse(click.user_agent)

    click.device_family = agent.device.family
    click.device_model = agent.device.model
    click.device_brand = agent.device.brand
    click.os_family = agent.os.family
    click.os_version = agent.os.version
    click.user_agent_family = agent.family
    click.user_agent_version = agent.version
  end
  # rubocop:enable Metrics/AbcSize
end
