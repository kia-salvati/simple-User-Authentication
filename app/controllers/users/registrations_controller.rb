class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :jsonapi

  def create
    user = Users::RegistrationService.run(sign_up_params)
    
    if user.valid?
      render jsonapi: user.result, include: %w(email jti),status: :created #201
    else
      render jsonapi_errors:  { detail: user.errors.messages }, status: :not_acceptable #406
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
