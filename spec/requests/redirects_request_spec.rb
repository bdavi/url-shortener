# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Redirects', type: :request do
  describe 'GET #show' do
    context 'when :slug param is an active link' do
      it "redirects to the link's url" do
        link = create(:link)

        get "/#{link.slug}"

        expect(response).to redirect_to(link.url)
      end

      it 'records the click' do
        ActiveJob::Base.queue_adapter = :test
        link = create(:link)

        expect do
          get "/#{link.slug}"
        end.to have_enqueued_job(RecordClickJob)
      end
    end

    context 'when :slug segment key is not an active link' do
      it 'raises a routing error' do
        expect do
          get '/invalid_slug'
        end.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
