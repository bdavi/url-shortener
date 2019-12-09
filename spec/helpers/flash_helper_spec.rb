# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashHelper, type: :helper do
  describe '#flash_is_displayable?' do
    context 'when the type is displayable' do
      it 'returns true' do
        expect(flash_is_displayable?('alert')).to be true
      end
    end

    context 'when the type is not displayable' do
      it 'returns false' do
        expect(flash_is_displayable?('random_data')).to be false
      end
    end

    describe '#alert_type' do
      it 'maps the flash type onto one of the alert types for display' do
        expect(alert_type('notice')).to eq 'info'
      end
    end
  end
end
