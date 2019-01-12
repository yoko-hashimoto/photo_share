Rails.application.routes.draw do
  root to: 'users#new'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]

  resources :photos do
    collection do
      post :confirm
    end
  end

end
