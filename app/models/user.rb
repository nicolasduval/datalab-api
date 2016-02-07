class User < ActiveRecord::Base
  # Include default devise modules.
  # :confirmable, :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  
  include DeviseTokenAuth::Concerns::User

  # serialize :tokens

end
