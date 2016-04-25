class AddLikesAndCommentsToPhotosTable < ActiveRecord::Migration
  def change
    add_column :photos, :likes, :integer, default: 0
    add_column :photos, :comments, :integer, default: 0
  end
end
