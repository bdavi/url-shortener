# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Links', type: :request do
  describe 'GET #redirect' do
    context 'when :slug param is an active link' do
      it 'returns http success' do
        link = create(:link)
        get "/#{link.slug}"
        expect(response).to redirect_to(link.url)
      end
    end

    context 'when :slug segment key is not an active link' do
      it 'returns raises a routing error' do
        expect do
          get '/invalid_slug'
        end.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe 'POST #create' do
    def create_params(url)
      {
        link: {
          url: url
        }
      }
    end

    context 'when params are valid' do
      it 'creates the link and redirects to dashboard#show' do
        expect do
          post links_path, params: create_params('http://www.abc.com')
        end.to change(Link, :count).by(1)

        expect(response).to redirect_to(root_url)
      end
    end

    context 'when params are invalid' do
      it 'does not create a link and redirects to dashboard#show' do
        expect do
          post links_path, params: create_params('invalid-url')
        end.not_to(change(Link, :count))

        expect(response).to redirect_to(root_url)
      end
    end
  end
end
