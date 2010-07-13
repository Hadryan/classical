ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.signup '/signup', :controller => 'users', :action => 'new'
	map.home '/home', :controller => 'home'

  map.resources :users
	map.resource  :session
  map.resources :instruments
  map.resources :composers
  map.resources :obra_types
  map.resources :solists
  map.resources :directors
  map.resources :orchestras
  map.resources :albums
  map.resources :users
  map.resources :logins
  map.resources :registrations
  map.resources :app_languages

  map.root :controller => 'home'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

