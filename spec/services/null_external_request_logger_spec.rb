# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NullExternalRequestLogger do
  it { is_expected.to respond_to :log }
end
