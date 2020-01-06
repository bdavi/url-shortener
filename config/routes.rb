# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  # Sidekiq Dashboard
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
    end
  end
  mount Sidekiq::Web => '/sidekiq'

  # Devise routes
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }

  # Match a slug on the root route only if it has a corresponding Link.
  # Using the constraint causes invalid slugs to return 404 which is the
  # preferred behavior.
  get '/:slug', to: 'redirects#show', constraints: ActiveSlugConstraint.new

  resources :links, only: [:create]
  resources :dashboard, only: [:index]
  root 'pages#home'
end
