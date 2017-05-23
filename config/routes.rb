Rails.application.routes.draw do

  get 'signup', to: 'users#new'
  post '/signup',  to: 'users#create'

  resources :recipes

  resources :foods, except: :show

  resources :users

#  get 'recipes/search/:id', to: 'recipes#search'
  get 'recipes/search/:name', to: 'recipes#search'

  root 'welcome#index'
end
