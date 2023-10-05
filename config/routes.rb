Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  constraints(id: /\d+/, user_id: /\d+/, author_id: /\d+/) do
    resources :users, only: %i[index show] do
      resources :posts, only: %i[index show new create] do
        resources :comments, only: %i[new create]
        resources :likes, only: %i[create]
      end
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'
end
