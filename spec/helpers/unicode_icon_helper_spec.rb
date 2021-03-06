# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UnicodeIconHelper, type: :helper do
  describe 'UnicodeIcon class' do
    subject(:icon) do
      UnicodeIconHelper::UnicodeIcon.new(decimal_code: decimal_code, char: char)
    end

    let(:decimal_code) { 9888 }
    let(:char) { '⚠' }

    it 'has the correct attributes', :aggregate_failures do
      is_expected.to respond_to :char
      is_expected.to respond_to :decimal_code
    end

    describe '#to_html' do
      it 'returns the (html safe) html character code' do
        html = icon.to_html
        expect(html).to eq '&#9888;'
        expect(html).to be_html_safe
      end
    end
  end

  describe 'unicode_icon' do
    it 'returns the correct html code' do
      expect(unicode_icon('warning_triangle')).to eq '&#9888;'
    end
  end
end
