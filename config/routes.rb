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

  match 'composers/composers_completion/', :to =>  "composers#composers_completion"
  match 'composers/composers_completion/:prefix', :to =>  "composers#composers_completion"

  root :to => 'home#index'
end

