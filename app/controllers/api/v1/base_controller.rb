module Api
  module V1

    class BaseController < ApplicationController
      
      before_action :create_model, only: [:create_attributes, :remove_attributes]

      # PUT /api/v1/create_attributes
      def create_attributes
        @obj   = @document[:document]
        param  = @document[:param_name]
        if @obj
          @obj.add_attributes(params[param])
          respond_data(@obj, 200)
        else
          respond_error("Could not find model #{param}", 400)
        end
      end

      # PUT /api/v1/rermove_attributes
      def remove_attributes
        obj   = @document[:document]
        param = @document[:param_name]
        if obj
          obj.remove_attributes(params[param])
          respond_data(obj, 200)
        end
      end

      private

      def models()
        model_paths = Dir["#{Rails.root}/app/models/**/*.rb"]
        sanitized_model_paths = model_paths.map { |path| path.gsub(/.*\/app\/models\//, '').gsub('.rb', '') }
        return sanitized_model_paths.each{|model| model.capitalize!}
      end

      def model(args)
        klass_name = args.capitalize
        if models.include?(klass_name)
          obj = Object.const_get(klass_name.capitalize)
          return obj
        else
          respond_error("Could not find model #{klass_name}", 400)
        end
      end

      # Befaore action
      def create_model
        param_name = params.keys()[0]
        obj        = model(param_name)
        @document  = { document: obj.find(params[:id]), 
                       param_name: param_name.to_sym } 
      end
  
    end
  end
end