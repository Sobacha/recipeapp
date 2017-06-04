Rails.application.routes.draw do

  # get 'sessions/new'
  get 'signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :recipes
  resources :foods, except: :show
  resources :users

  get 'recipes/search/:name', to: 'recipes#search'

  root 'welcome#home'

end
