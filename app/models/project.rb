class Project < ActiveRecord::Base

  validates_associated :company
  validates  :company_id, presence: :true
  validates  :name, presence: :true, uniqueness: { scope: :company, message: 'Project alredy exist.' }
  belongs_to :company
  has_many   :deliveries
  has_many   :edls

end
