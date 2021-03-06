Rails.application.routes.draw do

  devise_for :admins, :controllers => { :registrations => 'admins/registrations' }
  namespace :admins do
    root to: "admins#index"
    # to enable the creation of an admin by another admin:
    resources :admins
    post '/admins/new' => 'admins#create'
    resources :writing_definitions #do
    #   resources :writing_images, :only => [:create, :destroy]
    # end
    resources :writing_images
    resources :writing_informations
  end

  post '/admins/writing_definitions/clean'

  get 'home/home'
  get 'log/log'
  get 'home/index'
  get 'home/index2'

  
  root to: 'home#home'
  resources :writing_definitions
  resources :writing_images
  #resources :writing_informations
  
end
