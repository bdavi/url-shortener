# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET #show' do
    it 'returns http success' do
      get root_url

      expect(response).to have_http_status(:success)
    end
  end
end
