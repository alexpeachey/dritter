Dritter::Application.routes.draw do
  
  root to: 'posts#index'
  
  match 'sign_in' => 'sessions#new', as: :sign_in
  match 'sign_out' => 'sessions#destroy', as: :sign_out
  resources :sessions, only: [:new,:create,:destroy]
  
  match 'sign_up' => 'users#new', as: :sign_up
  resources :users do
    resources :posts, only: [:index,:destroy]
    resources :relationships, only: [:create, :destroy]
    member do
      get :followers
      get :followings
    end
  end
  
  resources :posts, only: [:index, :new, :create]

end
