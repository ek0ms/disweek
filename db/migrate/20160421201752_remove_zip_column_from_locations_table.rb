class RemoveZipColumnFromLocationsTable < ActiveRecord::Migration
  def change
    remove_column :locations, :zip, :string
  end
end
