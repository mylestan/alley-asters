class AddInvasiveToPlants < ActiveRecord::Migration[8.1]
  def change
    add_column :plants, :invasive, :boolean, default: false, null: false
  end
end
