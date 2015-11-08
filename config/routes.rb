Rails.application.routes.draw do
  resources :transactions, except: [:index, :destroy]
  root 'static_pages#index'
  get '/guest_signin', to: "guest_users#create", as: "guest_signin"
  get '/static_pages/index'
  get '/static_pages/faq', to: 'static_pages#faq', as: 'FAQ'
  get '/search', to: 'searches#show', as: 'search_show'
  post '/search', to: 'searches#create', as: 'search_create'

  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: "omniauth_callbacks"}
  resources :litter_boxes, except: [:destroy, :index]
  resources :unavailabilities, only: [:index], defaults: { format: 'json' }
end
