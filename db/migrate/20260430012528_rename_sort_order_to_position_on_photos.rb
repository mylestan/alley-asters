class RenameSortOrderToPositionOnPhotos < ActiveRecord::Migration[8.1]
  def change
    rename_column :photos, :sort_order, :position
  end
end
