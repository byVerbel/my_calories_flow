Rails.application.routes.draw do
  resources :dashboard, only: [:index]
  resources :calories
  devise_for :users, controllers: {
    confirmations: 'confirmations'
  }
  root to: 'static_pages#contact'
  get '/contact', to: 'static_pages#contact'
  get '/chart', to: 'calories#chart'
end
