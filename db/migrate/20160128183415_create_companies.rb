class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :full_address
      t.string :zip_code
      t.string :phone_number
      t.string :created_at, default: DateTime.now.to_formatted_s(:rfc822)
      t.string :updated_at, default: DateTime.now.to_formatted_s(:rfc822)
    end
  end
end
