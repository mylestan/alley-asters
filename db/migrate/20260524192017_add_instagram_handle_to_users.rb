class AddInstagramHandleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :instagram_handle, :string
  end
end
