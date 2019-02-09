class AnalyticsController < ApplicationController
  def index
    @total_products = Product.all.size
    @total_downloads = Product.where(download: true).size
    @categories = Category.all
    @estimate_month_time_to_download = (@total_products - @total_downloads)/20
  end
end