module Api
  module V1

    class EdlsController < Api::BaseController
      
      before_action :authenticate_user!
      before_action :restrict_api_access
      before_action :find_project_id, only: [:index, :create, :metadatas]
      before_action :find_edl_id, only: [:metadata, :parse]
      before_action :find_edl, only: [:show, :update,:destroy]

      def index
        @edls = Edl.where(project_id: @project.id)
        respond_data(@edls, 200)
      end

      def show
        if @edl
          respond_data(@edl, 200)
        end
      end

      def create
        @edl = Edl.make(params)
        if @edl.save
          respond_data(@edl, 201)
        else
          respond_error(@edl.errors, 404)
        end
      end

      def update
        if @edl.update_attributes(edl_params)
          respond_data(@edl, 200)
        else
          respond_error(@edl.errors, 400)
        end
      end

      def destroy
        if @edl.destroy
          head :no_content
        else
          respond_error(@edl.errors, 400)
        end
      end

      def metadata
        if @edl
          store = Parser::Edl.new(@edl)
          respond_data({ data: store.metadata } , 200)
        end
      end

      def metadatas
        if @project
          store = []
          @project.edls.each do |e|
            edl = Parser::Edl.new(e)
            store << edl.metadata
          end
          respond_data( { data: store }, 200)
        end
      end

      def parse
        if @edl
          store = Parser::Edl.new(@edl)
          respond_data(store.parse, 200)
        end
      end

      private

      def edl_params
        params.require(:edl).permit(:filename,:frame_rate, :content)
      end

      def find_project_id
        find_record? { @project = Project.find(params[:project_id]) }
      end

      def find_edl_id
        find_record? { @edl = Edl.find(params[:edl_id]) }
      end

      def find_edl
        find_record? { @edl = Edl.find(params[:id]) }
      end

    end

  end
end
