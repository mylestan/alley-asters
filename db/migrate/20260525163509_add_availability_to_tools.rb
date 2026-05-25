class AddAvailabilityToTools < ActiveRecord::Migration[8.1]
  def change
    add_column :tools, :self_serve, :boolean, default: false, null: false
    add_column :tools, :by_request, :boolean, default: false, null: false
  end
end
