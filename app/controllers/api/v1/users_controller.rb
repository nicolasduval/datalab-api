module Api
  module V1
    class UsersController < ApplicationController

      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_user!

      def index
      end

      def new
      end

      def show
        begin
         @user = User.find(params[:id])
         respond_data(@user, 200)
        rescue ActiveRecord::RecordNotFound  
         respond_error("Could not find user with id : #{params[:id]}" , 404)
        end
      end

      def create
      end

      def update
      end

      def destroy
      end

    end

  end
end
