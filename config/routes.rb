require 'api_constraints'

Mybusa::Application.routes.draw do
  root :to => "home#index"

  ActiveAdmin.routes(self)

  resources :opportunities, :only => [:index, :show]
  get 'find-opportunities', to: 'opportunities#index', as: :find_opportunities

  resources :sbir_solicitations do
    get 'prepopulate', to: 'sbir_solicitations#prepopulate', as: :prepopulate
  end

  resource :profile do
    resources :profile_people, as: 'people'
  end

  resources :sbir_apps

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  # API
  namespace :api, :defaults => {:format => :json} do
    scope :module => :v1, :constraints => ApiConstraints.new(:version => 1, :default => true) do
    	get '/index' => 'base#index'
      resources :profiles
    end
  end
end
