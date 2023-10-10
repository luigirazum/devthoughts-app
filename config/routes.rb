Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  constraints(id: /\d+/, user_id: /\d+/, author_id: /\d+/) do
    resources :posts, only: %i[new create] do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[create]
    end
    resources :users, only: %i[index show] do
      resources :posts, only: %i[index show]
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'
end
