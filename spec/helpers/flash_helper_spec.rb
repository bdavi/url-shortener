# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashHelper, type: :helper do
  describe '#flash_icon' do
    it 'calls unicode_icon with the correct value' do
      expect(helper).to receive(:unicode_icon).with('warning_triangle')
      helper.flash_icon('error')
    end
  end
end
