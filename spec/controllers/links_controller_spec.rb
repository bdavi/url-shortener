# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe 'GET #redirect' do
    context 'when :slug param is an active link' do
      it 'returns http success' do
        link = create(:link)
        get :redirect, params: { slug: link.slug }
        expect(response).to redirect_to(link.url)
      end
    end

    context 'when :slug param is not an active link' do
      it 'returns http success' do
        get :redirect, params: { slug: 'invalid slug' }
        expect(response.code).to eq '404'
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
          post :create, params: create_params('http://www.abc.com')
        end.to change { Link.count }.by(1)

        expect(response).to redirect_to(root_url)
      end
    end

    context 'when params are invalid' do
      it 'does not create a link and redirects to dashboard#show' do
        expect do
          post :create, params: create_params('invalid-url')
        end.to_not(change { Link.count })

        expect(response).to redirect_to(root_url)
      end
    end
  end
end
