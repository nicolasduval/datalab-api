class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|

      t.integer :user_id
      t.integer :project_id
      t.string  :reference
      t.integer :number
      t.string  :frame_rate
      t.string  :resolution
      t.string  :aspect_ratio
      t.string  :format
      t.string  :anamorphic
      t.string  :color_space
      t.string  :compression
      t.string  :subtitles
      t.string  :audio
      t.string  :approved,     default: "f"
      t.string  :status
      t.boolean :internal
      t.integer :assigned_to
      t.string  :delivery_method
      t.text    :remarks
      t.string  :checksum

      t.string  :created_at, default: DateTime.now.to_formatted_s(:rfc822)
      t.string  :updated_at, default: DateTime.now.to_formatted_s(:rfc822)
    end
  end
end