# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Endpoint for authenticating first-time users
  post 'authenticate', to: 'authentication#authenticate'

  # All API calls are packaged under /api since this is an API-only application
  namespace :api do

    # API calls for Product operations
    namespace :products do

      get '' => :index

      get '/:id' => :search
    end

    # API calls for Cart operations
    namespace :carts do

      get '' => :index

      post '' => :create

      put '/:id' => :update

      post '/:id/purchase' => :purchase
    end

  end

end
