class AddFrameRateToEdl < ActiveRecord::Migration
  def change
    add_column :edls, :frame_rate, :string
  end
end
