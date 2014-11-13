class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :title
      t.text :description
      t.float :old_price
      t.float :new_price
      t.integer :position

      t.timestamps
    end
  end
end
