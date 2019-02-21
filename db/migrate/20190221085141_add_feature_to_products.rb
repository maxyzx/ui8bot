class AddFeatureToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :feature, :boolean
  end
end
