Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get ':username', to: 'users#show', as: :user
  resources :users, only: [:show]
  resources :tweets, only: [:new, :create]
end
