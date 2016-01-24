module Api
  module V1

    class CompaniesController < ApplicationController
      
      before_action :find_company, only: [:show, :update, :destroy]

      #GET /api/v1/companies/
      def index
        @company = Company.all.to_a
        render json: @company
      end


      #GET /api/v1/companies/:id
      def show
        if @company
          #respond_data implemented ap1/v1/responce_helper.rb
          respond_data(@company, 200)
        else 
          #respond_error implemented ap1/v1/responce_helper.rb
          respond_error("Record not Found.", 404)
        end
      end

      #POST /api/v1/companies/
      def create
        @company = Company.new(companies_params)
        if @company.save
          respond_data(@company, 201)
        else
          respond_error("Record not created.", 400)
        end
      end

      #PUT /api/v1/companies/:id
      def update
      end
      
      #DELETE /api/v1/companies/:id
      def destroy
        if @company
          if @company.destroy
            head :no_content
          else
            respond_error("Record not delete.", 400)
          end
        else
          respond_error("Record not found.", 400)
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
