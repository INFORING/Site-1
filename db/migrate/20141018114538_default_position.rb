class DefaultPosition < ActiveRecord::Migration
  def change
  	change_column :offers, :position, :integer, default: 0
  end
end
