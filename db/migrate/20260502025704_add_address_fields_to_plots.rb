class AddAddressFieldsToPlots < ActiveRecord::Migration[8.1]
  def change
    add_column :plots, :address, :string
    add_column :plots, :sub_location, :string
  end
end
