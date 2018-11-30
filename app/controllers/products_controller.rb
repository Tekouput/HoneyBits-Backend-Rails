# frozen_string_literal: true

# Handles all the logic relative to the product management
class ProductsController < ApplicationController
  skip_before_action :authenticate_request,
  only: %w[
    show
    products_by_name
    get_favorites
    show_favorites
    show_popular
  ]

  before_action 'obtains_product',
  except: %w[
    create
    show
    products_by_name
    get_favorites
    show_favorites
    delete_favorites
    create_favorites
    show_popular
  ]

# ==============================================================================
# GET METHODS
# ==============================================================================

  # Get latest favorite products
  def get_favorites
    authenticate_rem
    follower = @current_user || User.find_by_id(params[:user_id])
    render json: Product.order(created_at: :desc).limit(20).map(&:simple_info.with(follower)),
    status: :ok
  end

  # Shows the information of a given product
  def show
    authenticate_rem
    follower = @current_user || User.find_by_id(params[:user_id])
    render json: Product.find(params[:id]).simple_info(follower), status: :ok
  end

  # Get multiple products by name
  def products_by_name
    render json: Product.where("name LIKE ? OR name LIKE ?", "#{params[:name]}%", "%#{params[:name]}%").offset(params[:offset]).limit(20).map(&:simple_info), status: :ok
  end

  # GET /products/popular
  def show_popular
    authenticate_rem
    follower = @current_user || User.find_by_id(params[:user_id])
    products = []

    sql = "SELECT COUNT(*) AS amount, pu.product_id
    FROM honeybits_production.products_users AS pu
    GROUP BY pu.product_id
    ORDER BY amount DESC
    LIMIT 1000;"

    records_array = ActiveRecord::Base.connection.execute(sql)
    records_array.each do |record|

      # record: [0: amount, 1: product_id]
      products << Product.find(record[1])
    end
    render json: products.map(&:simple_info.with(follower)), status: :ok
  end

# ==============================================================================
# MODIFYING / CREATE PRODUCTS
# ==============================================================================

  # Creates a product
  def create
    return unless product_params
    render json: Product.create_product(
      @product_params,
      category_list,
      @current_user.id
    ).simple_info, status: :created
  rescue => e
    render json: { error: e }, status: :bad_request
  end

  # Add an image to a product
  def add_image
    obtain_product_image_params
    pi = ProductImage.new(picture: @image_params)
    @product.product_images << pi
    render json: @product.simple_info, status: :ok
  rescue => e
    render json: { error: e }, status: :bad_request
  end

  # Updates a given product
  def update
    return unless product_params
    render json: @product.simple_info, status: :ok if @product.update!(@product_params)
  rescue => e
    render json: { error: e }, status: :ok
  end

  # Destroy a given product
  def destroy
    p @product.destroy!
    render json: { result: 'deleted' }, status: :ok
  end

# ==============================================================================
# FAVORITE PRODUCTS FUNCTIONS
# ==============================================================================

  # GET /products/favorites
  def show_favorites
    authenticate_rem
    follower = @current_user || User.find_by_id(params[:user_id])
    render json: follower.favorite_products.map(&:simple_info.with(follower)), status: :ok
  end

  # POST /products/favorite
  def create_favorites
    product = Product.find(params[:id])
    @current_user.favorite_products << product unless (@current_user.favorite_products.where(id: params[:id]).count > 0)
    @current_user.save!
    render json: product.simple_info(@current_user), status: :ok
  rescue => error
    p error
    render json: {error: error}, status: :bad_request
  end

  # DELETE /products/favorite
  def delete_favorites
    product = Product.find(params[:id])
    @current_user.favorite_products.destroy(product)
    render json: product.simple_info(@current_user), status: :ok
  rescue => error
    p error
    render json: {error: error}, status: :bad_request
  end

# ==============================================================================
# INTERNAL METHODS
# ==============================================================================

  private

  def obtain_product_image_params
    @image_params = params.require(:image)
  end

  # Gets the product object
  def obtains_product
    product = Product.find(params[:product_id])
    @product = product.user_id == @current_user.id ? product : nil
    (render(json: { e: 'AUTH' }, status: :unauthorized) && nil) if @product.nil?
  end

  # Sets the permitted params to receive
  def product_params
    if @current_user.shops.where(id: params[:product][:shop_id]).first
      @product_params = params.require(:product).permit(:name,
                                                        :description,
                                                        :price,
                                                        :rating,
                                                        :shop_id,
                                                        :category_id)
      true
    else
      render(json: { error: 'Not authorized' }, status: :unauthorized)
      false
    end
  end

  def category_list
    categories_name = params.require(:categories)
    categories = []
    categories_name.each do |ci|
      category = Category.where(name: ci).first_or_create
      categories << category
    end
    categories
  end
end
