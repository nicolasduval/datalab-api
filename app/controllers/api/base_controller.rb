module Api
  class BaseController < ApplicationController

    def name
      render json: { name: "datalab-api" }
    end

  end
end