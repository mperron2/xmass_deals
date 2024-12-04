Rails.application.routes.draw do
  devise_for :customers
  resources :customers
  resources :orders
  resources :order_items
  resources :cart, only: [ :create, :destroy ] do
    patch :update_quantity, on: :member
  end
  root to: "products#index"
  get "support/:page", to: "support#show", as: :static_page

  resources :products do
    collection do
      get "filter_by_category"
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
