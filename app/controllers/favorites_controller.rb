class FavoritesController < ApplicationController
  skip_before_action :authenticate_request, only: %i[favorites]

  # POST /favorite
  def favorite
    begin
      shop = Shop.find(params[:id])
      @current_user.favorites << shop
      @current_user.save!
      render json: shop.simple_info, status: :ok
    rescue => error
      p error
      favorites
    end
  end



  # DELETE /favorite
  def un_favorite
    begin
      shop = Shop.find(params[:id])
      @current_user.favorites.destroy(shop)
      render json: shop.simple_info, status: :ok
    rescue => error
      p error
      favorites
    end
  end

  # GET /favorites
  def favorites
    authenticate_rem
    follower = @current_user || User.find_by_id(params[:user_id])
    render json: follower.favorites.map(&:simple_info.with(follower)), status: :ok
  end
end

class Symbol
  def with(*args, &block)
    ->(caller, *rest) { caller.send(self, *rest, *args, &block) }
  end
end
