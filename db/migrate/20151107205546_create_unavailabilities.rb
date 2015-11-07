class CreateUnavailabilities < ActiveRecord::Migration
  def change
    create_table :unavailabilities do |t|
      t.references :litter_box, index: true, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
