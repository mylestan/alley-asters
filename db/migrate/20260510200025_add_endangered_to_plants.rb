class AddEndangeredToPlants < ActiveRecord::Migration[8.1]
  def change
    add_column :plants, :endangered, :boolean, default: false, null: false
  end
end
