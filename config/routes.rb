Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: [:show, :update] do
    member do
      patch :read_notifications, to: "users#read_notifications"
      patch :follow
      patch :unfollow
    end
  end

  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  get :my_feed, to: "pages#my_feed"

  resources :tois, only: %i[index show new create] do
    resources :bookmarks, only: %i[create]
  end

  resources :bookmarks, only: %i[index destroy]

  resources :posts, only: %i[new create]

end
