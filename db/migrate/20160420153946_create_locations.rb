class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :fb_id, null: false
      t.string :name, null: false
      t.string :category, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
    end
  end
end
