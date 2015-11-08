class AddNameToLitterBoxes < ActiveRecord::Migration
  def change
    add_column :litter_boxes, :name, :string
  end
end
