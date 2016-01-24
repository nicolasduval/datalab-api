class ApplicationController < ActionController::API
	Mongoid.raise_not_found_error = false
  include ActionController::RequestForgeryProtection
  
  include Api::V1::ResponceHelper

end
