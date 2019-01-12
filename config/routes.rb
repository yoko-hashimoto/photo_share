Rails.application.routes.draw do
  get 'sessions/new'

  root to: 'users#new'
  
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]

  resources :photos do
    collection do
      post :confirm
    end
  end

end
