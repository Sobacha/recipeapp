Rails.application.routes.draw do

  get 'signup', to: 'users#new'

  resources :recipes

  resources :foods, except: :show

#  get 'recipes/search/:id', to: 'recipes#search'
  get 'recipes/search/:name', to: 'recipes#search'

  root 'welcome#index'
end
