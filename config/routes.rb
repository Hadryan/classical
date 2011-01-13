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

  match '/albums/search', :to => "albums#search"

  #TODO Refactor this routes!!!

  match 'composers/composers_completion/', :to =>  "composers#composers_completion"
  match 'composers/composers_completion/:prefix', :to =>  "composers#composers_completion"

  match 'obra_types/obra_type_completion/', :to =>  "obra_types#obra_type_completion"
  match 'obra_types/obra_type_completion/:prefix', :to =>  "obra_types#obra_type_completion"

  match 'solists/solist_completion/', :to =>  "solists#solist_completion"
  match 'solists/solist_completion/:prefix', :to =>  "solists#solist_completion"

  match 'directors/director_completion/', :to =>  "directors#director_completion"
  match 'directors/director_completion/:prefix', :to =>  "directors#director_completion"

  match 'orchestras/orchestra_completion/', :to =>  "orchestras#orchestra_completion"
  match 'orchestras/orchestra_completion/:prefix', :to =>  "orchestras#orchestra_completion"

  match 'instruments/instrument_completion/', :to =>  "instruments#instrument_completion"
  match 'instruments/instrument_completion/:prefix', :to =>  "instruments#instrument_completion"

  #END :)

  root :to => 'albums#index'
end

