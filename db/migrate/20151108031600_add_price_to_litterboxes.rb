class AddPriceToLitterboxes < ActiveRecord::Migration
  def change
  	add_column :litter_boxes, :price, :integer, null: false, default: 99
  end
end
