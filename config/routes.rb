Grifter::Application.routes.draw do

  devise_for :users
  root to: 'gifts#index'
  resources :gifts

end
