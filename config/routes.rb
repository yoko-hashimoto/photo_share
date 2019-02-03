Rails.application.routes.draw do

  root to: 'photos#index'
  
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]

  resources :users do
    collection do
      post :confirm
    end
  end

  resources :photos do
    collection do
      post :confirm
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
