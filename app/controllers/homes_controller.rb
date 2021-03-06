class HomesController < ApplicationController
  def index
    @best_sellers = Product.where(best_seller: true)
    @new_arrivals = Product.order("created_at desc").limit(5)
    @favorites = Product.order("view desc").limit(5)

    @new_arrival_photo = @new_arrivals.first.photos.first.photo.thumb.url if @new_arrivals.present? && @new_arrivals.last.photos.present?
    @best_seller_photo = @best_sellers.last.photos.first.photo.thumb.url if @best_sellers.present? && @best_sellers.last.photos.present?
    @promotion_photo = Promotion.last.file.thumb.url if @promotion_photo.present?
  end

  def newest_products
    @newest_products = Product.order("created_at desc").limit(30)
  end

  def best_sellers
    @best_sellers = Product.where(best_seller: true)
  end

  def promotions
    @promotions = Promotion.all
  end

  def map
    
  end

  def about
    
  end

  def contact

  end
end