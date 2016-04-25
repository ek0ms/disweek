class AddPopularityColumnToPhotosTable < ActiveRecord::Migration
  def change
    add_column :photos, :popularity, :integer, default: 0
  end
end
