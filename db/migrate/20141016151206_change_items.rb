class ChangeItems < ActiveRecord::Migration
  def change
  	remove_column :items, :features
  end
end
