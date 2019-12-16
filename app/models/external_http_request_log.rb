# frozen_string_literal: true

# Used to record results of external http requests.
# This allows us handle bugs and/or extract additional information
# without redoing the external requests.
class ExternalHttpRequestLog < ApplicationRecord
  validates :kind, presence: true

  validates :response_body, presence: true

  validates :response_code, presence: true
end
