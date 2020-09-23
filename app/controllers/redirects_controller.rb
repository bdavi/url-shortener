# frozen_string_literal: true

# Controller for handling link redirection
class RedirectsController < ApplicationController
  delegate :env, to: :request

  def show
    link = Link.find_by(slug: params[:slug])
    _record_click(link)
    redirect_to link.url
  end

  private

  def _record_click(link)
    RecordClickJob.perform_later(link: link, request_data: _request_data)
  end

  def _request_data
    {
      host: env['HTTP_HOST'],
      user_agent: env['HTTP_USER_AGENT'],
      referer: env['HTTP_REFERER'].presence,
      clicked_at: DateTime.now,
      remote_ip: request.remote_ip
    }
  end
end
