class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.references :user, index: true, foreign_key: true
      t.text :description
      t.string :name
      t.string :breed
      t.string :gender, limit: 1
      t.string :spayed_slash_neutered, limit: 1
      t.boolean :clawed
      t.string :color

      t.timestamps null: false
    end
  end
end
