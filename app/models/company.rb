class Company < ActiveRecord::Base

  has_many :projects, dependent: :destroy
  has_and_belongs_to_many :users
  validates :name, presence: true, uniqueness: true

end
