class AddSlugToPlots < ActiveRecord::Migration[8.1]
  def change
    add_column :plots, :slug, :string
    add_index :plots, :slug, unique: true
  end
end
