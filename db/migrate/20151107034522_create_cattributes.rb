class CreateCattributes < ActiveRecord::Migration
  def change
    create_table :cattributes do |t|
    	t.string :name
    	t.string :upper_scale
    	t.string :lower_scale
      t.timestamps null: false
    end
  end
end
