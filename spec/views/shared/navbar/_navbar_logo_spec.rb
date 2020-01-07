# frozen_string_literal: true

require 'rails_helper'

describe 'shared/navbar/_navbar_logo', type: :view do
  it 'renders the application name' do
    render

    expect(rendered).to match(/SawFish/)
  end
end
