class AddStatusToPlots < ActiveRecord::Migration[8.1]
  def change
    add_column :plots, :status, :string, default: "potential", null: false
  end
end
