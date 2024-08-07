# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  resources :provider_organizations
  resources :credentials
  resources :requirements
  resources :profiles
  
  resources :imports


  devise_for :users,
    controllers: {
      sessions:           'users/sessions',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

    resources :users, except: :new
    resources :patients
    resources :documented_units
    resources :codes

    resources :visits do
      collection do
        post :import
      end
    end

  get 'welcome/index'
  # Defines the root path route ("/")
  root 'welcome#index'
end
