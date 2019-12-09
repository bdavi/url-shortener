# frozen_string_literal: true

require 'rails_helper'

describe 'rendering the flash' do
  it 'shows the displayable messages in the correct alert type' do
    flash = {
      'warning' => 'Check yourself before you wreck yourself',
      'notice' => 'You should know this.',
      'do_not_display' => 'should_not_be_rendered'
    }

    render partial: 'shared/flash', locals: { flash: flash }

    expect(rendered).to match /Check yourself/
    expect(rendered).to match /alert-info/
    expect(rendered).to_not match /notice/
    expect(rendered).to_not match /should_not_be_rendered/
    expect(rendered).to_not match /do_not_display/
  end
end
