require 'resque-scheduler'
require 'resque/scheduler/server'

Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'

  resources :settings, only: [:update, :edit]
  get '/settings', to: 'settings#show'
  #get '/histories/add', to: 'histories#add'
  get '/histories', to: 'home#validation_history'
  get '/add_history', to: 'histories#add_history'
  #resources :histories
  #post '/activate_charges/:id', to: 'home#activate_charges', as: 'activate_charges'
  #get '/index_charges', to: 'home#index_charges'
  #get '/create_charges', to: 'home#create_charges'
  get '/create_usage_charge', to: 'home#create_usage_charge'
  get '/activate_charge', to: 'home#activate_charge'
  get '/create_recurring_application_charge', to: 'home#create_recurring_application_charge', as: 'create_recurring'

  mount Resque::Server.new, :at => '/resque'

  #get '/activate_charge', to: 'home#activate_charge'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
