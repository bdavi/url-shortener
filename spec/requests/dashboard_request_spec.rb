# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  before { sign_in create(:user) }

  describe 'GET #show' do
    it 'returns http success' do
      get dashboard_index_url

      expect(response).to have_http_status(:success)
    end
  end
end
