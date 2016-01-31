class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.string  :name
      t.string  :frame_rate
      t.string  :color_space
      t.string  :aspect_ratio
      t.string  :resolution
      t.string  :production
      t.string  :supervisor
      t.string  :sound_studio
      t.string  :status
      t.integer :company_id
      t.string  :created_at, default: DateTime.now.to_formatted_s(:rfc822)
      t.string  :updated_at, default: DateTime.now.to_formatted_s(:rfc822)
    end
  end
end
