class CreateInventoryItems < ActiveRecord::Migration[8.1]
  def change
    create_table :inventory_items do |t|
      t.references :plant, null: false, foreign_key: true
      t.integer :quantity, default: 0, null: false
      t.string :status, default: "not_ready", null: false

      t.timestamps
    end
  end
end
