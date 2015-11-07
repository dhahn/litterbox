class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
    	t.text :comment
    	t.integer :paws
      t.timestamps null: false
    end
  end
end
