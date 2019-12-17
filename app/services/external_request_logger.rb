# frozen_string_literal: true

# Logger for handling external http requests
class ExternalRequestLogger
  def log(**attrs)
    ExternalHttpRequestLog.create(**attrs)
  end
end
