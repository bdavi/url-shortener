# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign In Request', type: :request do
  context 'when successful' do
    it 'redirects to dashboard_index_path' do
      user = create(:user)
      params = {
        user: {
          email: user.email,
          password: user.password
        }
      }

      post user_session_path, params: params

      expect(response).to redirect_to(dashboard_index_path)
    end
  end
end
