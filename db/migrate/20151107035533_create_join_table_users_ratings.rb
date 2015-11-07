class CreateJoinTableUsersRatings < ActiveRecord::Migration
  def change
    create_join_table :users, :ratings do |t|
      t.index [:user_id, :rating_id]
      t.index [:rating_id, :user_id]
    end
  end
end
