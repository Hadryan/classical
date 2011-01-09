Classical::Application.routes.draw do
  devise_for :users

  resources :instruments
  resources :composers
  resources :obra_types
  resources :solists
  resources :directors
  resources :orchestras
  resources :albums
  resources :app_languages

  root :to => 'home#index'
end

