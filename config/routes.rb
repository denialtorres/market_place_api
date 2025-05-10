Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Set the root path
  root "home#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Api definition

  namespace :api do
    namespace :v1 do
      get "docs", to: "docs#index", defaults: { format: "html" }

      defaults format: :json do
        resources :users, only: [ :show, :create, :update, :destroy ]
        resources :tokens, only: [ :create ]
        resources :products
        resources :orders, only: [ :index, :show, :create ]
      end
    end
  end



  # Render dynamic PWA files from app/views/pw
  # a/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
