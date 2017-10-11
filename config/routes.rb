Rails.application.routes.draw do
  resources :settings, only: [:update, :edit]
  get '/settings', to: 'settings#show'
  root :to => 'home#index'
  #get '/activate_charge', to: 'home#activate_charge'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
