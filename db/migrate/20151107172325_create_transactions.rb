class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :litter_box, index: true, foreign_key: true
      t.datetime :check_in
      t.datetime :check_out
      t.float :price, precision: 2

      t.timestamps null: false
    end
  end
end
