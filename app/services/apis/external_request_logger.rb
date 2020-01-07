# frozen_string_literal: true

# External APIs
module APIs
  # Logger for handling external http requests
  class ExternalRequestLogger
    def log(**attrs)
      ExternalHttpRequestLog.create(**attrs)
    end
  end
end
