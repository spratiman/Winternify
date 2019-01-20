# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do

    namespace :products do

      get '' => :index

      get '?instock=:value' => :filter

      get '/:id' => :search
    end

    namespace :cart do

      get '' => :index

      post '' => :create

      delete '/:id' => :destroy

      put '/:id' => :update

      post '/:id/purchase' => :purchase
    end

  end
  
end
