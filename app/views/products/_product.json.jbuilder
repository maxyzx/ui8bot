json.extract! product, :id, :_id, :name, :card_image, :category_id, :files_id, :created_at, :updated_at
json.url product_url(product, format: :json)
