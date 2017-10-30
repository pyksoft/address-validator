Rails.application.routes.draw do
  #resources :histories
  resources :settings, only: [:update, :edit]
  get '/settings', to: 'settings#show'
  get '/histories/add', to: 'histories#add'
  get '/histories', to: 'histories#index'

  root :to => 'home#index'
  #post '/activate_charges/:id', to: 'home#activate_charges', as: 'activate_charges'
  #get '/index_charges', to: 'home#index_charges'
  #get '/create_charges', to: 'home#create_charges'
  get '/create_usage_charge', to: 'home#create_usage_charge'
  get '/activate_charge', to: 'home#activate_charge'


  #get '/activate_charge', to: 'home#activate_charge'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
