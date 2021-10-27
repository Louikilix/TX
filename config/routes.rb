Rails.application.routes.draw do
  devise_for :admins
  namespace :admins do
      root to: "admins#index"
      resources :writing_definitions #do
      #   resources :writing_images, :only => [:create, :destroy]
      # end
      resources :writing_images
    end
  get 'home/home'
  get 'log/log'
  get 'home/index'
  root to: 'home#home'
  resources :writing_definitions
  resources :writing_images
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
