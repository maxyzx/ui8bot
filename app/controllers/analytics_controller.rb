class AnalyticsController < ApplicationController
  def index
    @total_products = Product.all.size
    @total_downloads = Product.where(download: true).size
    @categories = Category.all
  end
end