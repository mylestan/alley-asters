class AddNativePlantCoveragePercentToPlots < ActiveRecord::Migration[8.1]
  def change
    add_column :plots, :native_plant_coverage_percent, :float
  end
end
