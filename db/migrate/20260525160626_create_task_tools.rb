class CreateTaskTools < ActiveRecord::Migration[8.1]
  def change
    create_table :task_tools do |t|
      t.references :task, null: false, foreign_key: true
      t.references :tool, null: false, foreign_key: true
      t.string :requirement, default: "required", null: false

      t.timestamps
    end
  end
end
