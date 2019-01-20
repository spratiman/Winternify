class API::CartsController < ApplicationController
  # get cart details before every action
  before_action :fetch_cart

  # Get the cart
  def index
    @carts = Cart.all[0]
    fetch_cart_items
    fetch_cart_items_products
    render json: @carts.as_json.merge(:included_products => @cart_items_products_final)
  end

  # Create a cart
  def create
    @cart = Cart.new(params[:completed])

    if @cart.save
      render json: @cart, status: :created, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  private

  # Get cart info based on cart id
  def fetch_cart
    @cart = Cart.find_by_id(params[:id])
  end

  def fetch_cart_items
    @cart_items_final = []
    cart_id = @carts.id
    cart_items = CartItem.all
    cart_items.each do |cart_item|
      if cart_item.cart_id == cart_id
        @cart_items_final << cart_item
      end
    end
  end

  def fetch_cart_items_products
    @cart_items_products_final = []
    @cart_items_final.each do |cart_item|
      @cart_items_products_final << Product.find_by_id(cart_item.product_id)
    end
  end

end
