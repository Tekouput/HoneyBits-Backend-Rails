class CartsController < ApplicationController

  def show
    render json: get_cart.simple_info, status: :ok
  end

  def add_item
    product = Product.find(params[:id])
    get_cart.products << product
    render json: {}, status: :ok
  end

  def remove_item
    product = Product.find(params[:id])
    get_cart.products.remove(product)
  end

  private

  def get_cart
    @current_user.carts.first_or_create(open: true)
  end

end
