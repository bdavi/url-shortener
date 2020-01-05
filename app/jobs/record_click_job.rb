# frozen_string_literal: true

# Records a link click
class RecordClickJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(link:, env_data:, clicked_at:, remote_ip:, creator: LinkClicks::Creator.new)
    creator.create(
      link: link,
      env_data: env_data,
      clicked_at: clicked_at,
      remote_ip: remote_ip
    )
  end
end
