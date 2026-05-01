class CreatePlots < ActiveRecord::Migration[8.1]
  def change
    create_table :plots do |t|
      t.string :name
      t.integer :square_footage
      t.decimal :latitude
      t.decimal :longitude
      t.date :first_planted
      t.integer :initial_plant_count
      t.text :notes
      t.text :plants_removed
      t.boolean :managed_by_us, default: true

      t.timestamps
    end
  end
end
