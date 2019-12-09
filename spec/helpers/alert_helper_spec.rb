# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlertHelper, type: :helper do
  describe '#alert_icon' do
    it 'calls unicode_icon with the correct value' do
      expect(helper).to receive(:unicode_icon).with('warning_triangle')
      helper.alert_icon('error')
    end
  end
end
