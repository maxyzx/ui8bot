class AnalyticsController < ApplicationController
  def index
    @total_products = Product.all.size
    @product_downloads = Product.where(download: true).order(:download_at)
    @categories = Category.all
    @estimate_month_time_to_download = (@total_products - @product_downloads.size)/20
  end
end