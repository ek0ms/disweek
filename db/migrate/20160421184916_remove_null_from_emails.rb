class RemoveNullFromEmails < ActiveRecord::Migration
  def up
    change_column :users, :email, :string, default: ""
  end

  def down
    change_column :users, :email, :string, null: false, default: ""
  end
end
