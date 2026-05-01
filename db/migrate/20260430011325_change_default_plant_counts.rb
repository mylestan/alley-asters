class ChangeDefaultPlantCounts < ActiveRecord::Migration[8.1]
  def change
    change_column_default :plots, :initial_plant_count, from: nil, to: 0
    change_column_default :plots, :added_plant_count, from: nil, to: 0
  end
end
