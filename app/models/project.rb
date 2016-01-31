class Project < ActiveRecord::Base

  validates  :name, presence: :true
  validates  :company_id, presence: :true
  validates_associated :company
  belongs_to :company

end
