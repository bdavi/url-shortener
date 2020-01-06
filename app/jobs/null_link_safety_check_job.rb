# frozen_string_literal: true

# Stands in for a LinkSafetyCheckJob when we don't want to check safety
class NullLinkSafetyCheckJob
  def perform(*args, **kwargs); end

  def self.perform_later(*args, **kwargs); end
end
