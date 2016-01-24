module Api
  module V1

    class ProjectsController < ApplicationController 

      before_action :find_project, only: [:show, :update, :destroy]

      #GET /api/v1/projects
      def index
        @projects = Project.all.to_a
        render json: @projects
      end

      #GET /api/v1/projects/:id
      def show
        if @project
          respond_data(@project, 200)
        else 
          respond_error("Record not Found.", 404)
        end
      end

      #POST /api/v1/projects/
      def create
        @project = Project.new(projects_params)
        @project.write_attributes(projects_params.merge(params[:project]))
        if @project.save
          respond_data(@project, 201)
        else
          respond_error("Project not created.", 400)
        end
      end
      
      #PUT /api/v1/projects/:id
      def update
        if @project
          @project.update_document(params[:project])
          @project.upsert
          respond_data(@project, 200)
        else
          respond_error("Record not Updated.", 400)
        end
      end

      #DELETE /api/v1/projects/:id
      def destroy
        if @project
          if @project.destroy
            head :no_content
          else
            respond_error("Record not delete.", 400)
          end
        else
          respond_error("Record not found.", 400)
        end
      end


      private

      def projects_params
        params.require(:project).permit(:name)
      end

      def find_project
        @project = Project.find(params[:id])
      end

    end

  end
end
