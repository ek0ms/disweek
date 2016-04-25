class ChangeStreetToNotNullInLocationsTable < ActiveRecord::Migration
  def up
    change_column :locations, :street, :string
  end

  def down
    change_column :locations, :street, :string, null: false
  end
end
