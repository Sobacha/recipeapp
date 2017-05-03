Rails.application.routes.draw do

  resources :recipes

  resources :foods, except: :show

#  get 'recipes/search/:id', to: 'recipes#search'
  get 'recipes/search/:name', to: 'recipes#search'

  root 'welcome#index'
end
