class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :plot, null: false, foreign_key: true
      t.datetime :completed_at
      t.text :completion_notes

      t.timestamps
    end
  end
end
