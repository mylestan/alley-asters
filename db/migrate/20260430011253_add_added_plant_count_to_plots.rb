class AddAddedPlantCountToPlots < ActiveRecord::Migration[8.1]
  def change
    add_column :plots, :added_plant_count, :integer
  end
end
