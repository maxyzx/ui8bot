class AddFilesToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :multiple_file, :boolean
  end
end
