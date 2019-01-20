# frozen_string_literal: true

class API::ProductsController < ApplicationController
  # get product details before every action
  before_action :fetch_product

  # List all products
  def index
    @products = Product.all
    if (params[:instock] && params[:instock] == "true")
      filter
    else
      render json: @products
    end
  end

  # Search for specific product
  def search
    render json: @product
  end

  private

  # Get product info based on product id
  def fetch_product
    @product = Product.find_by_id(params[:id])
  end

  # Filter for instock products
  def filter
    products_final = []
    @products.each do |product|
      if product.inStock
        products_final << product
      end
    end
    render json: products_final
  end
end
