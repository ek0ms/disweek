class AddNullFalseToColumnsInUsersTable < ActiveRecord::Migration
  def up
    change_column :users, :uid, :string, null: false
    change_column :users, :provider, :string, null: false
    change_column :users, :nickname, :string, null: false
    change_column :users, :pic, :string, null: false
  end

  def down
    change_column :users, :uid, :string
    change_column :users, :provider, :string
    change_column :users, :nickname, :string
    change_column :users, :pic, :string
  end
end
