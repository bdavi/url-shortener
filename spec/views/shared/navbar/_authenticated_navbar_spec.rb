# frozen_string_literal: true

require 'rails_helper'

describe 'shared/navbar/_authenticated_navbar', type: :view do
  it 'renders shared/navbar/_navbar_logo' do
    stub_template 'shared/navbar/_navbar_logo.html.erb' => 'abc123'

    render

    expect(rendered).to match(/abc123/)
  end

  it 'allows sign out' do
    render

    expect(rendered).to match(/Sign Out/)
  end

  it 'links to the dashboard_index_path' do
    render

    expect(rendered).to match(dashboard_index_path)
  end
end
