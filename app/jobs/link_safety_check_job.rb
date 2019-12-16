# frozen_string_literal: true

# Performs a safety check for user submitted URL and updates link
class LinkSafetyCheckJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(link, api: GoogleSafeBrowsingApi.new)
    if api.url_is_safe?(link.url)
      link.approved!
    else
      link.failed_safety_check!
    end
  end
end
