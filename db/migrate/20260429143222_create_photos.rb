class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.references :plot, null: false, foreign_key: true
      t.string :caption
      t.integer :sort_order

      t.timestamps
    end
  end
end
