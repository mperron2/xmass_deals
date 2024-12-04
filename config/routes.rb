Rails.application.routes.draw do
  devise_for :customers
  resources :customers
  resources :orders
  resources :order_items

  resources :cart, only: [ :create, :destroy ] do
    patch :update_quantity, on: :member
  end

  resources :checkout, only: [ :index ] do
    patch "update_quantity/:id", to: "checkout#update_quantity", as: "update_quantity"
    get "confirm", on: :collection
  end

  get "confirm", to: "checkout#confirm", as: "confirm"
  get "checkout", to: "checkout#index", as: "checkout"

  # Root path
  root to: "products#index"

  # Static page support route
  get "support/:page", to: "support#show", as: :static_page

  # Product routes
  resources :products do
    collection do
      get "filter_by_category"
    end
  end

  # Admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA files
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
