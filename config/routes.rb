# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do

  devise_for :users, 
    controllers: {                                 
      sessions:           'users/sessions',                                                                             
      omniauth_callbacks: 'users/omniauth_callbacks'                                      
    }
  
    resources :users
    resources :patients
    resources :visits

  get 'welcome/index'
  # Defines the root path route ("/")
  root 'welcome#index'
end
