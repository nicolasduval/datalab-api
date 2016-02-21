module Api
  module V1

    class ProjectsController < ApplicationController 
      before_action :authenticate_user!
      before_action :find_project, only: [:show, :update, :destroy]

      #GET /api/projects
      def index
        find_record? { @company = Company.find(params[:company_id]) }
        if @company
          respond_data(@company.projects, 200)
        end
      end

      #GET /api/projects/:id
      def show
        respond_data(@project, 200)
      end

      #POST /api/projects/
      def create
        @project = Project.new(projects_params)
        if @project.save
          respond_data(@project, 201)
        else
          respond_error(@project.errors, 400)
        end
      end
      
      #PUT /api/projects/:id
      def update
        if @project.update_attributes(projects_params)
          respond_data(@project, 200)
        else
          respond_error(@project.errors, 400)
        end
      end

      #DELETE /api/projects/:id
      def destroy
        if @project.destroy
          head :no_content
        else
          respond_error(@project.errors, 400)
        end
      end


      private

      def projects_params
        params.require(:project).permit(:name,:company_id,:frame_rate,:color_space,
          :aspect_ratio,:resolution,:production,:supervisor,:sound_studio,:status)
      end

      def find_project
        find_record? { @project = Project.find(params[:id]) }
      end

    end

  end
end
