Rails.application.routes.draw do
  get '/:slug', to: 'redirect#redirect'
  post 'create_link', to: 'dashboard#create_link'
  root 'dashboard#show'
end
