# app/controllers/authentication_controller.rb

class AuthenticationController < ApplicationController
  def register
    @user = User.new(user_params)
    if @user.save
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :ok
    elsif @user.nil?
      render json: { errors: 'User not found' }, status: :unauthorized
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.jwt_secret)
  end
end
