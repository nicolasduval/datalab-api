module Api::V1::ResponceHelper

  def error(args)
    return { error: args }
  end

  def respond_error(arg, status)
    render json: error(arg), status: status
  end

  def respond_data(arg, status)
    render json: arg, status: status
  end

  def find_record?
    begin
      yield
    rescue ActiveRecord::RecordNotFound  
      respond_error("Could not find record" , 404)
    end
  end

end
