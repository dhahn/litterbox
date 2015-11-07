Rails.application.routes.draw do
  root 'static_pages#index'
  get 'static_pages/index'
  get 'static_pages/faq', to: 'static_pages#faq', as: 'FAQ'
  get '/search', to: 'searches#show', as: 'search_show'

  devise_for :users, class_name: 'FormUser', :controllers => { registrations: 'registrations', omniauth_callbacks: "omniauth_callbacks" }
  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end
  resources :litter_boxes
end
