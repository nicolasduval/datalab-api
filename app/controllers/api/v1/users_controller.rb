module Api
  module V1
    class UsersController < Api::BaseController
      
      before_action :authenticate_user!
      before_action :restrict_api_access
      before_action :find_user, only: [:show, :update, :destroy]
      before_action :find_user_id, only: [:companies, :deliveries]

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
          CompaniesUsers.create!(company_id: params[:company_id], user_id: @user.id)
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
        @user.companies.destroy_all
        if @user.destroy
          head :no_content
        else
          respond_error(@user.errors, 400)
        end
      end

      def logged_in_user
        respond_data(current_user, 200)
      end

      def companies
        respond_data(@user.companies, 200)
      end

      def deliveries
        respond_data(@user.deliveries, 200)
      end

      private



      def users_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_number, :job_title )
      end

      def find_user
        find_record? { @user = User.find(params[:id]) }
      end

      def find_user_id
        find_record? { @user = User.find(params[:user_id]) }
      end

    end

  end
end
