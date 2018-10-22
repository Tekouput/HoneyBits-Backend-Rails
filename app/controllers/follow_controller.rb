# frozen_string_literal: true

class FollowController < ApplicationController
  skip_before_action :authenticate_request, only: %i[show show_with_user_simple]

  def follow
    follower = @current_user
    followed = User.find(params[:user_id])
    Follow.create!(follower: follower, followed: followed)
  end

  def unfollow
    follower = @current_user
    followed = User.find(params[:user_id])
    follow_dat = Follow.where(follower: follower, followed: followed)
    follow_dat.first&.destroy!
    render json: {}, status: :ok
  end

  def show
    authenticate_rem
    follower = @current_user || User.find_by_id(params[:user_id_follower])
    followed = User.find(params[:user_id_followed])
    follow_dat = Follow.where(follower: follower, followed: followed)
    render json: follow_dat.first&.simple_info, status: :ok
  end

  def show_with_user_simple
    authenticate_rem
    follower = @current_user || User.find_by_id(params[:user_id_follower])
    followed = User.find(params[:user_id_followed])
    follow_dat = Follow.where(follower: follower, followed: followed)
    render json: follow_dat.first&.users_info, status: :ok
  end
end
