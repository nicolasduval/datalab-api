require "api_constraints"

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    
    # Api::BaseController
    get "name" => "base#name"

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      
      # V1 BaseController
      # put "create_attributes/:id" => "base#create_attributes"
      # put "remove_attributes/:id" => "base#remove_attributes"

      resources :projects
      resources :companies

    end

  end
end
