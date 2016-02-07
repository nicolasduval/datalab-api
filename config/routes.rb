require "api_constraints"

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    
    # Api::BaseController
    get "name" => "base#name"

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      
      resources :users
      resources :projects
      resources :companies

    end

  end

  scope '/api' do
    mount_devise_token_auth_for 'User', at: '/auth'
  end

end
