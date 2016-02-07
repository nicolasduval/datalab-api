module Api
  module V1
    class UsersController < ApplicationController

      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_user!

      def index
        find_record? { @users = User.all }
        respond_data(@users, 200)
      end

      def new
      end

      def show
        find_record? { @user = User.find(params[:id]) }
        respond_data(@user, 200)
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
