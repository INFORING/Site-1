class AddShowToItems < ActiveRecord::Migration
  def change
  	add_column :items, :show, :boolean, default: false
  end
end
