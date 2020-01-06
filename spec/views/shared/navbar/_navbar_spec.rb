# frozen_string_literal: true

require 'rails_helper'

describe 'shared/navbar/_navbar', type: :view do
  context 'when there is no current_user' do
    it 'renders shared/navbar/unauthenticated_navbar' do
      stub_template 'shared/navbar/_unauthenticated_navbar.html.erb' => 'abc123'
      render
      expect(rendered).to match(/abc123/)
    end
  end

  context 'when there is a current_user' do
    it 'renders shared/navbar/unauthenticated_navbar' do
      allow(view).to receive(:current_user).and_return(instance_double('User'))
      stub_template 'shared/navbar/_authenticated_navbar.html.erb' => 'abc123'
      render
      expect(rendered).to match(/abc123/)
    end
  end
end
