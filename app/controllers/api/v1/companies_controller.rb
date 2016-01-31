module Api
  module V1

    class CompaniesController < ApplicationController
      
      before_action :find_company, only: [:show, :update, :destroy]

      #GET /api/companies/
      def index
        @company = Company.all
        render json: @company
      end


      #GET /api/companies/:id
      def new
        @company = Company.new()
      end

      #GET /api/companies/:id
      def show
        if @company
          respond_data(@company, 200)
        else 
          respond_error("Record not Found.", 404)
        end
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
        @company.update_attributes(params[:company])
        if @company
          respond_data(@company, 200)
        else
          respond_error(@company.errors, 400)
        end
      end
      
      #DELETE /apicompanies/:id
      def destroy
        if @company
          if @company.destroy
            head :no_content
          else
            respond_error(@company.errors.full_messages, 400)
          end
        else
          respond_error(@company.errors.full_messages, 400)
        end
      end


      private 

      def companies_params
        params.require(:company).permit(:name)
      end

      # Before action 
      def find_company
        @company = Company.find(params[:id])
      end



    end

  end
end
