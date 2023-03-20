class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user!, only: %i[create destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:signup, keys: [:username])
  end

  def authenticate_user!
    token = request.params[:user]
    request.params[:user] = GenerateToken::JwtAuth.decode(token)
  end
end
