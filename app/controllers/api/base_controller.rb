module Api
  
  class BaseController < ApplicationController

    include ActionController::ImplicitRender
    include ActionController::HttpAuthentication::Token::ControllerMethods

    def name
      render json: { name: "datalab-api" }
    end

    private

    def restrict_api_access
      authenticate_or_request_with_http_token do |token, option|
        ApiKey.exists?(access_token: token)
      end
    end

  end
end