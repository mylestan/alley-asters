class RenameAdminsToUsers < ActiveRecord::Migration[8.1]
  def change
    rename_table :admins, :users
    add_column :users, :is_admin, :boolean, default: false, null: false
  end
end
