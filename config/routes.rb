require "api_constraints"

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    
    # Api::BaseController
    get "name" => "base#name"

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      
      resources :companies do
        get 'users' => 'companies#users'
      end
      
      get 'current_user' => 'users#logged_in_user'
      resources :users do
        get 'companies'    =>  'users#companies'
        get 'deliveries'   => 'users#deliveries'
      end
      
      resources :projects do
        get 'deliveries' => 'projects#deliveries'
      end
      
      resources :deliveries do 
        get "created_by" => "deliveries#created_by"
      end

      # Timecode
      scope :timecode do 
        post 'to_frames'   => 'timecode#to_frames'
        post 'to_timecode' => 'timecode#to_timecode'
        post 'add'         => 'timecode#add'
        post 'sub'         => 'timecode#sub'
      end

    end

  end

  scope '/api' do
    mount_devise_token_auth_for 'User', at: '/auth'
  end

end
