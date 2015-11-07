class CreateLitterBoxes < ActiveRecord::Migration
  def change
    create_table :litter_boxes do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :capacity
      t.text :description
      t.string :city
      t.string :state
      t.string :address_line_1
      t.string :address_line_2
      t.string :zip
      t.integer :number_of_adults
      t.integer :number_of_children
      t.integer :number_of_pets

      t.timestamps null: false
    end
  end
end
