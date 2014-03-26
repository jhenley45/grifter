Grifter::Application.routes.draw do

  # get "user_venmos/index"
  # get "user_venmos/new"
  # get "user_venmos/create"
  # get "user_venmos/update"

  get 'user_venmos/confirm_venmo' => 'user_venmos#confirm_venmo'

  devise_for :users
  resources :user_venmos

  resources :gifts do
  	resources :pledges
  end

  root to: 'gifts#index'
end
