class RemoveFbidAndCategoryFromLocationsTable < ActiveRecord::Migration
  def change
    remove_column :locations, :fb_id, :string
    remove_column :locations, :category, :string
  end
end
