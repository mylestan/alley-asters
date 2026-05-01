class AddDetailsToPlants < ActiveRecord::Migration[8.1]
  def change
    add_column :plants, :latin_name, :string
    add_column :plants, :is_native, :boolean, default: true, null: false
  end
end
