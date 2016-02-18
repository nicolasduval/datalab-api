module Api
  module V1
    class UsersController < ApplicationController
      
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_user!
      before_action :find_user, only: [:show, :update, :destroy]

      #GET /api/users/
      def index
        find_record? { @users = User.all }
        respond_data(@users, 200)
      end
      
      #GET /api/users/:id
      def show
        respond_data(@user, 200)
      end

      #POST /api/users/
      def create
        @user = User.new(users_params)
        if @user.save
          respond_data(@user, 201)
        else
          respond_error(@user.errors, 400)
        end
      end

      #PUT /api/users/:id
      def update
        @user.update_attributes(users_params)
        respond_data(@user, 200)
      end
      
      #DELETE /api/users/:id
      def destroy
        # @user.companies.destroy_all
        if @user.destroy
          head :no_content
        else
          respond_error(@user.errors, 400)
        end
      end

      private

      def users_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_number, :job_title )
      end

      def find_user
        find_record? { @user = User.find(params[:id]) }
      end

    end

  end
end
