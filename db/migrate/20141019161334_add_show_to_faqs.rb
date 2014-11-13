class AddShowToFaqs < ActiveRecord::Migration
  def change
  	add_column :faqs, :show, :boolean, default: false
  	add_column :reviews, :show, :boolean, default: false
  end
end
