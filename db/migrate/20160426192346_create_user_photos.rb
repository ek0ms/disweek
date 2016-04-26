class CreateUserPhotos < ActiveRecord::Migration
  def change
    create_table :user_photos do |t|
      t.belongs_to :user, null: false
      t.belongs_to :photo, null: false
    end
  end
end
