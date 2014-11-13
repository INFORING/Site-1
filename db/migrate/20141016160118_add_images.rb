class AddImages < ActiveRecord::Migration
  def change
  	add_attachment :items, :image
  	add_attachment :reviews, :image
  	add_attachment :preorders, :image
  	add_attachment :offers, :image

  end
end
