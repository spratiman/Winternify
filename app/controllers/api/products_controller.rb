# frozen_string_literal: true

class API::ProductsController < ApplicationController
  # Validate authenticity of api requests
  # before_action :check_authenticity

  # get product details before every action
  before_action :fetch_product

  # List all products
  def index
    @products = Product.all
    render json: @products
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
end
