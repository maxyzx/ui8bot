# Crawler::Fetcher.new.run

module Crawler
  class Fetcher

    def run
      for page in 1..pages
        import_data Crawler::Data.new(page).products
      end
    end

    private

    def import_data products
      products.each do |product|
        if Product.find_by__id(product['_id']).present?
          update_product_files product
        else
          params = {
            _id: product['_id'],
            name: product['name'],
            card_image: product['card_image'],
            slug: product['slug']
          }
          new_product = Product.new(params)
          new_product.category = initialize_category product
          new_product.product_files = initialize_file product
          new_product.save
        end
      end
    end

    def update_product_files product
      current_product = Product.find_by__id(product['_id'])
      return if current_product.download
      product['files'].each do |file|
        current_product.product_files.destroy_all
        current_product.product_files = initialize_file product
        current_product.save
      end
    end

    def initialize_file product
      return [] unless product['files'].present?
      files = []
      product['files'].each do |file|
        params = {
          _id: file['_id'],
          name: file['name']
        }
        new_file = ProductFile.new(params)
        new_file.save
        files << new_file
      end
      files
    end

    def initialize_category product
      return nil unless product['category'].present?
      _id = product['category'].first['_id']
      category_name = product['category'].first['name']
      existing_category = Category.find_by_name category_name 

      if existing_category.present?
        existing_category
      else      
        params = {
          _id: _id,
          name: category_name
        }

        new_category = Category.new(params)
        new_category.save
        new_category
      end
    end

    def pages
      @pages ||= meta['pages']
    end

    def meta
      @meta ||= Crawler::Data.new(0).meta
    end
  end
end