Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :items, only: [:show, :new, :create, :destroy] do
    resources :reviews, only: [:show, :new, :create, :destroy]
    collection do
      get :search
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :reviews, only: [:show, :destroy]
end
