Rails.application.routes.draw do
  get 'work_patterns/edit'
  get 'work_patterns/index'
  devise_for :users
  root to: "homes#top"
  resources :shifts, only: [:new, :show, :create, :edit, :index, :update, :destroy] do
    resources :workers, only: [:update, :create, :edit, :destroy]
  end
  get 'shifts/preview', as: "preview"
  # get 'shifts/new'
  # get 'shifts/index'
  # get 'shifts/show'
  # get 'shifts/edit'
  resources :shops, only: [:edit, :index, :create, :update, :destroy]
  # get 'shops/new'
  # get 'shops/index'
  # get 'shops/edit'
  resources :staffs, only: [:edit, :index, :create, :update, :destroy]
  # get 'staffs/index'
  # get 'staffs/edit'
  resources :users, only: [:edit, :update, :destroy]
  # get 'users/edit'
  resources :work_patterns, only: [:edit, :index, :create, :update, :destroy]
  # get 'work_pattern/index'
  # get 'work_pattern/edit'
  get 'configs/index'
  get 'homes/about', as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
