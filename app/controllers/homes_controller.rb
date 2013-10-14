class HomesController < ApplicationController
  def index
    @best_sellers = Product.where(best_seller: true).limit(2)
    @new_arrivals = Product.order("created_at desc").limit(2)
  end

  def show
    @product = Product.find(params[:id])
  end

  def newest_products
    @newest_products = Product.where("created_at > ?", Time.now - 30.days)
  end

  def best_sellers
    @best_sellers = Product.where(best_seller: true)
  end

  def promotions
    
  end
end