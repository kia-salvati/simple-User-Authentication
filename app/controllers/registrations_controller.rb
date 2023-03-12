class RegistrationsController < ApplicationController
  respond_to :json

  def create
    user = User.new(sign_up_params)
    
    if user.save
      token = user.generate_jwt
      render json: { token: token }
    else
      render json:  { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private 

  def sign_up_params
    params.require(:user).permit(
      :username,
      :email,
      :password
    )
  end
end
