Rails.application.routes.draw do
  devise_for :users, path: '/',
                     path_names: { sign_in: 'login', sign_out: 'logout', password: 'reset',
                                   confirmation: 'confirm', unlock: 'unblock', registration: 'register',
                                   sign_up: 'signup' }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'signup', to: 'devise/registrations#new'
    # root to: 'devise/sessions#new'
  end

  constraints(id: /\d+/, user_id: /\d+/, author_id: /\d+/) do
    resources :posts, only: %i[new create] do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[create]
    end
    resources :users, only: %i[index show] do
      resources :posts, only: %i[index show]
    end
  end

  # # Defines the root path route ("/")
  # # root "articles#index"
  root 'users#index'
end
