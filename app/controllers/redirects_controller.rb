# frozen_string_literal: true

# Controller for handling link redirection
class RedirectsController < ApplicationController
  RECORDABLE_ENV_KEYS = %w[HTTP_HOST HTTP_USER_AGENT HTTP_REFERER REMOTE_ADDR].freeze

  def show
    link = Link.find_by(slug: params[:slug])
    RecordClickJob.perform_later(link, _recordable_env)
    redirect_to link.url
  end

  private

  def _recordable_env
    request.env.slice(*RECORDABLE_ENV_KEYS)
  end
end