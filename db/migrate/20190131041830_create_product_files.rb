class CreateProductFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :product_files do |t|
      t.string :_id
      t.string :name
      t.belongs_to :product, index: true
      t.timestamps
    end
  end
end
