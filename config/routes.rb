require 'api_constraints'

Mybusa::Application.routes.draw do
  ActiveAdmin.routes(self)
  root :to => "home#index"

  resources :opportunities, :only => [:index, :show]
  get '/opportunities/mo/:mo_id' => 'opportunities#show_mo'
  get 'find-opportunities', to: 'opportunities#index', as: :find_opportunities

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  # API
   namespace :api, :defaults => {:format => :json} do
    scope :module => :v1, :constraints => ApiConstraints.new(:version => 1, :default => true) do
    	get '/' => 'base#index'
      resource :profile, :only => [:show]
    end
  end
end
