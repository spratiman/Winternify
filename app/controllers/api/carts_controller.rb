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
    @cart = Cart.new(cart_params)

    if @cart.save
      render json: @cart, status: :created
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # Add products to the cart
  def update
    @cart = Cart.find_by_id(params[:id])
    params[:cart].each do |cart_item|
      @cart_item = cart_item
      create_cart_item
    end

    cart_total_price = 0;
    @cart_items = CartItem.all
    @cart_items.each do |cart_item|
      if cart_item.cart_id.to_s == params[:id].to_s
        temporary_price = cart_item.quantity * Product.find_by_id(cart_item.product_id).price
        cart_total_price += temporary_price
      end
    end

    params[:total_cost] = cart_total_price
    params[:purchased] = false
    if @cart.update(params.permit(:total_cost, :purchased))
      render json: @cart, status: :ok
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # Complete the cart purchase
  def purchase
    @cart = Cart.find_by_id(params[:id])
    @cart_items = CartItem.all
    error = nil
    temporary_price = 0
    @cart_items.each do |cart_item|
      if cart_item.cart_id.to_s == params[:id].to_s
        @product = Product.find_by_id(cart_item.product_id)
        temporary_price = @product.inventory_count.to_i - cart_item.quantity.to_i
        if (temporary_price.to_i) <= 0.to_i
          error = "The inventory is empty for the product with id "+@product.id.to_s
          params[:inventory_count] = 0.to_i
          params[:inStock] = false
          if @product.update(params.permit(:inventory_count, :inStock))
            puts "inventory_count updated for "+@product.id.to_s
          else
            puts "inventory_count failed to update for "+@product.id.to_s
          end
        else
          params[:inventory_count] = temporary_price.to_i
          params[:inStock] = true
          if @product.update(params.permit(:inventory_count, :inStock))
            puts "inventory_count updated for "+@product.id.to_s
          else
            puts "inventory_count failed to update for "+@product.id.to_s
          end
        end
      end
    end

    if error.nil?
      params[:purchased] = true
      params[:completed] = true
      if @cart.update(params.permit(:completed, :purchased))
        render json: @cart, status: :ok
      end
    else
      render json: {cart_error: @cart.errors, error: error}, status: :unprocessable_entity
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

  def create_cart_item
    params[:cart_id] = params[:id]
    params[:product_id] = @cart_item[:product_id]
    params[:quantity] = @cart_item[:quantity]

    @cart_item = CartItem.new(params.permit(:product_id, :cart_id, :quantity))
    if @cart_item.save
      puts "CartItem saved to Cart"
    else
      puts "CartItem didn't save to Cart, please try again"
    end
  end

  def cart_params
    params.require(:cart).permit(:completed, :product_id, :quantity)
  end

end
