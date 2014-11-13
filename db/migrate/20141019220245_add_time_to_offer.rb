class AddTimeToOffer < ActiveRecord::Migration
  def change
  	add_column :offers, :end_at, :datetime
  end
end
