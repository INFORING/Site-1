class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :item_id
      t.integer :preorder_id
      t.integer :offer_id
      t.string :title
      t.text :value

      t.timestamps
    end
  end
end
