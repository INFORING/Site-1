class AddEmailToReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :email, :string
  end
end
