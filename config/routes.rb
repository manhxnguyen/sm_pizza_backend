Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    namespace :v1 do
      # Authentication routes
      post "login", to: "auth#login"
      delete "logout", to: "auth#logout"
      get "profile", to: "auth#profile"

      # Dashboard route
      get "dashboard", to: "dashboard#index"

      # Resource routes
      resources :toppings
      resources :pizzas do
        member do
          post :add_topping
          delete :remove_topping
        end
      end
    end
  end

  # Root route
  root to: proc { [ 200, {}, [ "Pizza Management API v1.0" ] ] }
end
