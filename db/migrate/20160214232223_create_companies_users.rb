class CreateCompaniesUsers < ActiveRecord::Migration
  def change
    create_table :companies_users do |t|
      t.integer :user_id
      t.integer :company_id
      t.string  :created_at, default: DateTime.now.to_formatted_s(:rfc822)
      t.string  :updated_at, default: DateTime.now.to_formatted_s(:rfc822)
    end
    add_index :companies_users, :user_id
    add_index :companies_users, :company_id
  end
end
