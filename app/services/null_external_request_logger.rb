# frozen_string_literal: true

# Null logger for when we don't want to log a request
class NullExternalRequestLogger
  # noop
  def log(**kwargs); end
end
