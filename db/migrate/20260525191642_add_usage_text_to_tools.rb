class AddUsageTextToTools < ActiveRecord::Migration[8.1]
  def change
    add_column :tools, :usage_text, :text
  end
end
