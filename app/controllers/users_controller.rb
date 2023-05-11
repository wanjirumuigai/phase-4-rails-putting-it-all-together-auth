class UsersController < ApplicationController
skip_before_action :authorize, only: [:create]
  def create

    user = User.create!(signup_params)
    session[:user_id] = user.id
render json: user, status: :created
rescue ActiveRecord::RecordInvalid => e
  render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      end

  def show
    user = User.find_by(id: session[:user_id])

    if user
      render json: user
    else
      render json: { error: ["Not authorized" ]}, status: :unauthorized
    end
  end

  private

  def signup_params
    params.permit(:username, :password,:password_confirmation, :image_url, :bio)
  end

end
