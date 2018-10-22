# frozen_string_literal: true

# Allow the user to connect with the app through other services
class OmniauthLoginController < ApplicationController

  skip_before_action :authenticate_request, only: :omniauth_token

  # Performs the login logic for facebook and google
  def omniauth_token
    case params[:provider]
    when 'facebook'
      object = Facebook.get_object(extract_token,
                                   '/me?fields=id,name,picture,email')
      command = facebook(object)
      render json: {
        auth_token: command[:token],
        user: command[:user].simple_info
      }, status: :ok
    when 'google'
      object = Google.get_object(extract_token)
      command = google(object)
      render json: {
        auth_token: command[:token],
        user: command[:user].simple_info
      }, status: :ok
    else
      render json: { error: 'No available function for that provider' },
             status: :bad_request
    end
  end

  # Logic for facebook
  def facebook(object)
    command = AuthenticateUserOauth.call(object['email']).result
    user = command[:user]

    # Update user information
    user.uuid = object['id']
    user.provider = 'facebook'
    user.first_name = object['name']
    user.profile_pic = object['picture']['data']['url']
    user.email = object['email']
    # Set random password for user
    if command[:new_record?] || user.password_digest.blank?
      user.password = SecureRandom.urlsafe_base64(nil, false)
    end

    user.save!
    command
  end

  # Logic for google
  def google(object)
    command = AuthenticateUserOauth.call(object['email']).result
    user = command[:user]

    # Update user information
    user.uuid = object['id']
    user.provider = 'google'
    user.first_name = object['given_name']
    user.last_name = object['family_name']
    user.profile_pic = object["picture"]
    user.email = object["email"]

    # Set random password for user
    if command[:new_record?]
      user.password = SecureRandom.urlsafe_base64(nil, false)
    end

    user.save!
    command
  end

  def extract_token
    request.env['HTTP_AUTHORIZATION']
  end
end
