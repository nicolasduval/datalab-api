class ApplicationController < ActionController::API
  include Api::V1::ResponceHelper
  include DeviseTokenAuth::Concerns::SetUserByToken
end
