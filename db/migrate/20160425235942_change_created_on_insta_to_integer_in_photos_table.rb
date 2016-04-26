class ChangeCreatedOnInstaToIntegerInPhotosTable < ActiveRecord::Migration
  def up
    change_column :photos, :created_on_insta, 'integer USING CAST
      ("created_on_insta" AS integer)', null: false
  end

  def down
    change_column :photos, :created_on_insta, 'varchar USING CAST
      ("created_on_insta" AS varchar(255))', null: false
  end
end
