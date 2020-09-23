# frozen_string_literal: true

# Records a link click
class RecordClickJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(link:, request_data:, creator: LinkClicks::Creator.new)
    creator.create(link: link, request_data: request_data)
  end
end
