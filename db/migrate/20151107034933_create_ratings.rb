class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :transaction_id
    	t.text :comment
    	t.integer :paws
      t.timestamps null: false
    end

    # add_index :ratings, :user_id
    # add_foreign_key :ratings, :users, column: :user_id, primary_key: :id

    # add_index :ratings, :transaction_id
    # add_foreign_key :ratings, :transactions, column: :transaction_id, primary_key: :id
  end
end
