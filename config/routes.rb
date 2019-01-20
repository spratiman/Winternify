# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'authenticate', to: 'authentication#authenticate'

  namespace :api do

    namespace :products do

      get '' => :index

      get '/:id' => :search
    end

    namespace :carts do

      get '' => :index

      post '' => :create

      delete '/:id' => :destroy

      put '/:id' => :update

      post '/:id/purchase' => :purchase
    end

  end

end
