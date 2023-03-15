class Users::SessionsController < Devise::SessionsController
  respond_to :jsonapi
  
  def create
    user = Users::CreateSessionService.run(params: user_params)
    
    if user.valid?
      # sign_in(user)
      render jsonapi: user.result, fields: { user: %w(jti) }, status: :accepted #202
    else
      render jsonapi_errors: { detail: user.errors.messages }, status: :not_acceptable #406
    end
  end

  def destroy
    user = Users::DestroySessionService.run(params: user_params)

    if user.valid?
      render jsonapi: user.result ,status: :accepted #202
      # sign_out(user)
    else
      render jsonapi_errors: { detail: user.errors.messages }, status: :not_acceptable #406
    end
  end

  def user_params
    params[:user].require(:payload).permit(
      :email,
      :password,
      :username,
      :jti
    )
  end
end

