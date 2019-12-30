# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NullExternalRequestLogger, type: :service do
  it { is_expected.to respond_to :log }
end
