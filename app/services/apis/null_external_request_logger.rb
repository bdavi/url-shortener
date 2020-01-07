# frozen_string_literal: true

# External APIs
module APIs
  # Null logger for when we don't want to log a request
  class NullExternalRequestLogger
    def log(**kwargs); end
  end
end
