class AddPreorderToItem < ActiveRecord::Migration
  def change
  	add_column :items, :preorder, :boolean, default: false
  end
end
