Rails.application.routes.draw do

  devise_for :users

  root "static_pages#home"

  get "home" => "activities#index"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :books
  resources :reviews
  resources :comments
  resources :requests, only: [:index, :create, :destroy]
  resources :users, only: [:index, :show]
  resources :favorites, only: [:index, :create, :destroy]
  resources :readings, only: [:create, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :activities, only: [:index]
  resources :likes, only: [:create, :destroy]

  get "/users/:id/:type" => "relationships#index", as: "follow"

  namespace :admin do
    root "dashboards#home"
    resources :requests do
      collection do
        post :batch_update
      end
    end
    resources :categories
    resources :books
    resources :users, except: [:edit, :update]
  end
end
