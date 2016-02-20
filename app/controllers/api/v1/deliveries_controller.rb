module Api
  module V1

    class DeliveriesController < ApplicationController

      before_action :find_delivery, only: [:show, :update, :destroy]
      
      def index
        find_record? { @project = Project.find(params[:project_id]) }
        if @project
          respond_data(@project.deliveries, 200)
        end
      end

      def show
        respond_data(@delivery, 200)
      end

      def create
        @delivery = Delivery.new(deliveries_params)
        if @delivery.save
          respond_data(@delivery, 201)
        else
          respond_error(@delivery.errors, 400)
        end
      end

      def update
        @delivery.update_attributes(deliveries_params)
        respond_data(@delivery, 200)
      end

      def destroy
        if @delivery.destroy
          head :no_content
        else
          respond_error(@delivery.errors, 400)
        end
      end

      private

      def deliveries_params
        params.require(:delivery).permit(
                  :user_id,:project_id,:reference,:number,:frame_rate,:resolution,
                  :aspect_ratio,:format,:anamorphic,:color_space,:compression,
                  :subtitles,:audio,:approved,:status,:internal,:assigned_to,
                  :delivery_method,:remarks,:checksum )
      end

      def find_delivery
        find_record? { @delivery = Delivery.find(params[:id]) }
      end


    end

  end
end