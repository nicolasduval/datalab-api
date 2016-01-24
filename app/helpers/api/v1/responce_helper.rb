module Api::V1::ResponceHelper

  def error(args)
    return { error: args }
  end

  def data(args)
    return { data: args }
  end

  def respond_error(arg, status)
    render json: error(arg), status: status
  end

  def respond_data(arg, status)
    render json: data(arg), status: status
  end

end
