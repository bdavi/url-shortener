# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashHelper, type: :helper do
  describe '#flash_icon' do
    it 'calls unicode_icon with the correct value' do
      icon_double = instance_double('String')
      allow(helper).to receive(:unicode_icon).with('warning_triangle').and_return(icon_double)
      expect(helper.flash_icon('error')).to eq icon_double
    end
  end
end
