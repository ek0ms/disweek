class AddPopularityToLocationsTable < ActiveRecord::Migration
  def change
    add_column :locations, :popularity, :integer, default: 0
  end
end
