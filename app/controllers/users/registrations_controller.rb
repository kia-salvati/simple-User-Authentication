class Users::RegistrationsController < Devise::SessionsController
  def create
    user = Users::RegistrationService.run(params: sign_up_params)
    
    if user.valid?
      render jsonapi: user.result, fields: { user: %w(email jti) }, status: :created #201
    else
      render jsonapi_errors:  { detail: user.errors.messages }, status: :not_acceptable #406
    end
  end
  
  private

  def sign_up_params
    params[:user].require(:payload).permit(
      :username,
      :email,
      :password
    )
  end
end
