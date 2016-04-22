class AddInstaIdToLocationsTable < ActiveRecord::Migration
  def change
    add_column :locations, :insta_id, :string
  end
end
