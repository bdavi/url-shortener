# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Links', type: :request do
  describe 'POST #create' do
    def create_params(url)
      {
        link: {
          url: url
        }
      }
    end

    before { sign_in create(:user) }

    context 'when params are valid' do
      it 'creates the link and redirects to dashboard#show' do
        expect do
          post links_path, params: create_params('http://www.abc.com')
        end.to change(Link, :count).by(1)

        expect(response).to redirect_to(dashboard_index_url)
      end
    end

    context 'when params are invalid' do
      it 'does not create a link and redirects to dashboard#show' do
        expect do
          post links_path, params: create_params('invalid-url')
        end.not_to(change(Link, :count))

        expect(response).to redirect_to(dashboard_index_url)
      end
    end
  end
end
