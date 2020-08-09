Rails.application.routes.draw do
  root to: 'home#index'

  resources :car_categories #7 rotas do crud
  resources :subsidiaries
end
