class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :update, :destroy, :show_products, :latest_products]
  skip_before_action :authenticate_request, only: [:show, :favorites, :show_products, :latest_products, :shops_by_name, :show_listings]


    def shops_by_name
      render json: Shop.where("name LIKE ? OR name LIKE ?", "#{params[:name]}%", "%#{params[:name]}%").map(&:simple_info), status: :ok
    end

  # GET /shops/latest_products
  def latest_products
    render json: @shop.products.offset(params[:offset]).limit(params[:limit]).order(created_at: :desc).map(&:simple_info), status: :ok
  end

  # GET /shops/products
  def show_products
    render json: @shop.products.map(&:simple_info), status: :ok
  end

  # GET /shops
  def index
    @shops = Shop.all
    render json: @shops
  end

# GET /shops/products/show_listings
  def show_listings
    render json: Shop.where("name LIKE ? OR name LIKE ?", "#{params[:name]}%", "%#{params[:name]}%").offset(params[:offset]).limit(20).map(&:listing_info), status: :ok
  end

  # GET /shops/favorites
  def favorites
    authenticate_rem
    @current_user ||= User.find_by_id(params[:user_id])
    render json: Shop.last(5).map(&:simple_info.with(@current_user)), status: :ok
  end

  # GET /shops/1
  def show
    render json: @shop.simple_info, status: :ok
  end

  # GET /user/shops
  def my_shops
    render json: @current_user.shops.map(&:simple_info), status: :ok
  end

  # POST /shops
  def create
    @shop = Shop.create!(
      name: params[:title],
      description: params[:description],
      latitude: params[:latitude],
      longitude: params[:longitude],
      place_id: params[:place_id],
      shop_picture: params[:shop_picture],
      shop_logo: params[:shop_logo],
      policy: params[:policy]
    )

    @current_user.shops << @shop

    if @shop
      render json: @shop.simple_info, status: :created
    else
      render json: @shop.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shops/1
  def update
    if shop = @current_user.shops.find(params[:id])
      shop.update!(
        name: params[:title].blank? ? shop.name : params[:title],
        description: params[:description].blank? ? shop.description : params[:description],
        latitude: params[:latitude].blank? ? shop.latitude : params[:latitude],
        longitude: params[:longitude].blank? ? shop.longitude : params[:longitude],
        place_id: params[:place_id].blank? ? shop.place_id : params[:place_id],
        shop_picture: params[:shop_picture].blank? ? shop.shop_picture : params[:shop_picture],
        shop_logo: params[:shop_logo].blank? ? shop.shop_logo : params[:shop_logo],
        policy: params[:policy]
      )
      render json: @shop.simple_info
    else
      render json: @shop.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shops/1
  def destroy
    @shop.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_shop
    @shop = Shop.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def shop_params
    params.fetch(:shop, {})
  end
end
