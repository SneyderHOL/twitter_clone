Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get ':username', to: 'users#home', as: :user
  get ':username/tweets', to: 'users#show', as: :user_tweets
  get ':username/followees', to: 'users#followees', as: :user_followees
  get ':username/followers', to: 'users#followers', as: :user_followers
  get ':username/follow', to: 'users#follow', as: :follow_user
  post ':username/follow', to: 'users#follow_to', as: :to_follow_user
  # resources :users, only: [:show]
  resources :tweets, only: [:new, :create]
end
