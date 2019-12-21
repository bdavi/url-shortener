# frozen_string_literal: true

# Records a link click
class ClickRecorder
  def record_click(link, env_data)
    click = LinkClick.new(link: link)
    _assign_env_attrs(click, env_data)
    click.save!
    click
  end

  private

  def _assign_env_attrs(click, env_data)
    click.host = env_data['HTTP_HOST']
    click.user_agent = env_data['HTTP_USER_AGENT']
    click.referer = env_data['HTTP_REFERER'].presence
    click.anonymized_ip = _anonymize(env_data['REMOTE_ADDR'])
  end

  def _anonymize(ip)
    ip&.sub(/\w*\z/, 'X')
  end
end
