class User < ActiveRecord::Base
  # Include default devise modules.
  # :confirmable, :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :companies
  has_many :deliveries
  include DeviseTokenAuth::Concerns::User

end
