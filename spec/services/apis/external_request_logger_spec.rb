# frozen_string_literal: true

require 'rails_helper'

RSpec.describe APIs::ExternalRequestLogger, type: :service do
  subject(:logger) { described_class.new }

  describe '#log' do
    it 'creates a ExternalHttpRequestLog with the passed args' do
      logger.log(
        kind: 'SomeClass#method',
        response_code: 403,
        response_body: 'you are forbidden'
      )

      log_entry = ExternalHttpRequestLog.find_by(kind: 'SomeClass#method')

      expect(log_entry).to have_attributes(
        response_code: 403,
        response_body: 'you are forbidden'
      )
    end
  end
end
