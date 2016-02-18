module Api
  module V1

    class CompaniesController < ApplicationController
      
      before_action :find_company, only: [:show, :update, :destroy]
      # before_action :authenticate_user!

      #GET /api/companies/
      def index
        @company = Company.all
        render json: @company, status: 200
      end


      #GET /api/companies/:id
      def new
        @company = Company.new()
      end

      #GET /api/companies/:id
      def show
        respond_data(@company, 200)
      end

      #POST /api/companies/
      def create
        @company = Company.new(companies_params)
        if @company.save
          respond_data(@company, 201)
        else
          respond_error("Record not created.", 400)
        end
      end

      #PUT /api/companies/:id
      def update
        @company.update_attributes(companies_params)
        respond_data(@company, 200)
      end
      
      #DELETE /apicompanies/:id
      def destroy
        @company.users.destroy_all
        @company.destroy
      end

      def users
        find_record? { @company = Company.find(params[:company_id]) }
        respond_data(@company.users, 200)
      end

      private 

      def companies_params
        params.require(:company).permit(:name)
      end

      # Before action 
      def find_company
        find_record? { @company = Company.find(params[:id]) }
      end



    end

  end
end
