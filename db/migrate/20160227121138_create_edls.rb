class CreateEdls < ActiveRecord::Migration
  def change
    create_table :edls do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :filename
      t.text :content
      t.string :created_at, default: DateTime.now.to_formatted_s(:rfc822)
      t.string :updated_at, default: DateTime.now.to_formatted_s(:rfc822)

    end
  end
end
