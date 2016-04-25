class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :link, null: false
      t.string :low_res_link, null: false
      t.string :created_on_insta, null: false
      t.string :username, null: false
      t.string :profile_picture, null: false
      t.string :caption, null: false
      t.belongs_to :location, null: false

      t.timestamps null: false
    end
  end
end
