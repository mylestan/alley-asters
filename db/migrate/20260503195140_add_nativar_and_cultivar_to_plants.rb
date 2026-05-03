class AddNativarAndCultivarToPlants < ActiveRecord::Migration[8.1]
  def change
    add_column :plants, :nativar, :boolean, default: false, null: false
    add_column :plants, :cultivar, :boolean, default: false, null: false
  end
end
