Rails.application.routes.draw do
  devise_for :admins, :controllers => { :registrations => 'admins/registrations' }
  namespace :admins do
    root to: "admins#index"
    get '/admins/edit'
    patch '/admins/edit'
    resources :writing_definitions #do
    #   resources :writing_images, :only => [:create, :destroy]
    # end

    resources :writing_images
  end

  post '/admins/writing_definitions/clean'

  get 'home/home'
  get 'log/log'
  get 'home/index'
  get 'home/index2'
  get 'home/index2Bin'
  get 'home/index2M'
  
  root to: 'home#home'
  resources :writing_definitions
  resources :writing_images
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
