class AddHasSignageToPlots < ActiveRecord::Migration[8.1]
  def change
    add_column :plots, :has_signage, :boolean, default: false, null: false
  end
end
