class AddDownloadAtToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :download_at, :datetime
  end
end
