class AddCanopyLayerToPlants < ActiveRecord::Migration[8.1]
  def change
    add_column :plants, :canopy_layer, :string, default: "ground", null: false
  end
end
