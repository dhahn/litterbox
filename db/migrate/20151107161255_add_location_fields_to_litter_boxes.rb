class AddLocationFieldsToLitterBoxes < ActiveRecord::Migration
  def change
    add_column :litter_boxes, :latitude, :float
    add_column :litter_boxes, :longitude, :float
  end
end
