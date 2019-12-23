# frozen_string_literal: true

# Controller for handling link redirection
class RedirectsController < ApplicationController
  RECORDABLE_ENV_KEYS = %w[HTTP_HOST HTTP_USER_AGENT HTTP_REFERER].freeze

  def show
    link = Link.find_by(slug: params[:slug])
    _record_click(link)
    redirect_to link.url
  end

  private

  def _record_click(link)
    RecordClickJob.perform_later(
      link: link,
      env_data: _recordable_env,
      clicked_at: DateTime.now,
      remote_ip: request.remote_ip
    )
  end

  def _recordable_env
    request.env.slice(*RECORDABLE_ENV_KEYS)
  end
end
