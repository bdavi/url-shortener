# frozen_string_literal: true

Rails.application.routes.draw do
  # Match a slug on the root route only if it has a corresponding Link.
  # Using the constraint causes invalid slugs to return 404 which is the
  # preferred behavior.
  get '/:slug', to: 'links#redirect', constraints: ActiveSlugConstraint.new

  resources :links, only: [:create]
  root 'dashboard#show'
end
