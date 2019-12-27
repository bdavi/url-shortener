# frozen_string_literal: true

# == Schema Information
#
# Table name: external_http_request_logs
#
#  id            :bigint           not null, primary key
#  kind          :text             not null
#  meta          :jsonb
#  response_body :text             not null
#  response_code :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Used to record results of external http requests.
# This allows us handle bugs and/or extract additional information
# without redoing the external requests.
class ExternalHttpRequestLog < ApplicationRecord
  validates :kind, presence: true

  validates :response_body, presence: true

  validates :response_code, presence: true
end
