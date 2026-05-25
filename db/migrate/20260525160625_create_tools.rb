class CreateTools < ActiveRecord::Migration[8.1]
  def change
    create_table :tools do |t|
      t.string :name

      t.timestamps
    end
  end
end
