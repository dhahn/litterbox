class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rater_id
      t.integer :ratee_id
    	t.text :comment
    	t.integer :paws
      t.timestamps null: false
    end

    add_index :ratings, :rater_id
    add_foreign_key :ratings, :users, column: :rater_id, primary_key: :id

    add_index :ratings, :ratee_id
    add_foreign_key :ratings, :users, column: :ratee_id, primary_key: :id
  end
end
