Rails.application.routes.draw do
  root to: 'home#index'

  resources :car_categories, only: [:index, :show, :new, :create, :edit, :update, :destroy] 
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update, :destroy] 
end
