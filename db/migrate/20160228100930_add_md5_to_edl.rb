class AddMd5ToEdl < ActiveRecord::Migration
  def change
    add_column :edls, :md5, :string
  end
end
