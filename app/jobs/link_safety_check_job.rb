# frozen_string_literal: true

# Performs a safety check for user submitted URL and updates link
class LinkSafetyCheckJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(link, url_checker: GoogleSafeBrowsingApi.new)
    result = url_checker.lookup_url(link.url)
    _persist_results_of_check(result)

    if result.safe?
      link.approved!
    else
      link.failed_safety_check!
    end
  end

  private

  def _persist_results_of_check(result)
    ExternalHttpRequestLog.create(
      kind: 'GoogleSafeBrowsingApi#lookup_url',
      meta: {
        url_tested: result.url_tested,
        safe?: result.safe?
      },
      response_body: result.body,
      response_code: result.code
    )
  end
end
