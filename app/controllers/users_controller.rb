# frozen_string_literal: true

# Defines the users methods
class UsersController < ApplicationController

  skip_before_action :authenticate_request, only: [:create, :token, :show, :valid]

  def show_feed

    {
      products: [],
      stores: []
    }

  end

  def create
    if User.find_by_email params[:email]
      render json: {error: 'User exist'}, status: :bad_request
    else
      user = User.create!(
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        first_name: params[:first_name],
        last_name: params[:last_name],
        sex: params[:sex],
        birthday: params[:birthday]
      )
      render json: user.simple_info, status: :ok
    end
  rescue => e
    render json: { error: e }, status: :bad_request
  end

  def token
    command = AuthenticateUser.call(params[:email], params[:password])
    if command.success?
      render json: { auth_token: command.result, user: command.user.simple_info }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  rescue => e
    render json: { error: e }, status: :bad_request
  end

  def update
    show
  rescue => e
    render json: { error: e }, status: :bad_request
  end

  def show
    authenticate_rem
    render json: @current_user.try(:simple_info) ||
                 User.find_by_id(params[:user_id]).try(:simple_info) ||
                 User.all.map(&:simple_info),
           status: :ok
  rescue => e
    render json: { error: e }, status: :bad_request
  end

  def valid
    authenticate_rem
    render json: { valid: !(@current_user.try(:simple_info).eql? nil) },
           status: :ok
  end

end
