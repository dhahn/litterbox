Rails.application.routes.draw do
  resources :transactions
  root 'static_pages#index'
  get 'static_pages/index'
  get 'static_pages/faq', to: 'static_pages#faq', as: 'FAQ'
  get '/search', to: 'searches#show', as: 'search_show'
  post '/search', to: 'searches#create', as: 'search_create'

  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: "omniauth_callbacks"}
  resources :litter_boxes
end
