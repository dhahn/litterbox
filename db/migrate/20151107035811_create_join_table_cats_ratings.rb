class CreateJoinTableCatsRatings < ActiveRecord::Migration
  def change
    create_join_table :cats, :ratings do |t|
      t.index [:cat_id, :rating_id]
      t.index [:rating_id, :cat_id]
    end
  end
end
