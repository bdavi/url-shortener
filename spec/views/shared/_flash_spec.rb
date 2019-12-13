# frozen_string_literal: true

require 'rails_helper'

describe 'rendering the flash' do
  it 'shows the displayable messages in the correct flash type' do
    flash = {
      'alert' => 'Check yourself before you wreck yourself',
      'notice' => ['You should know this.', 'and this!'],
      'do_not_display' => 'should_not_be_rendered'
    }

    render partial: 'shared/flash', locals: { flash: flash }

    expect(rendered).to     match(/Check yourself/)
    expect(rendered).to     match(/flash-alert/)
    expect(rendered).to     match(/You should/)
    expect(rendered).to     match(/and this/)
    expect(rendered).not_to match(/should_not_be_rendered/)
    expect(rendered).not_to match(/do_not_display/)
  end
end
