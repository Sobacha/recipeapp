Rails.application.routes.draw do

  resources :recipes do
    resources :foods, except: :show
  end

  resources :foods do
    resources :recipes
  end

  root 'welcome#index'
end
