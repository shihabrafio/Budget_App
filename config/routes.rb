Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :user, only: [:new] do
    resources :category, only: [:index, :new, :create]
  end
  resources :expense, only: [:new, :create, :index]

  authenticated(:user) do
    root to: 'category#index', as: :authenticated_root
  end
  unauthenticated(:user) do
    root 'home#index'
  end

end