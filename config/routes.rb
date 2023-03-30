Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  get 'home/about', to: 'home#about', as: 'about'
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  resources :users, only: [:show, :edit, :update, :index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end