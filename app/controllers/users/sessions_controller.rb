class Users::SessionsController < Devise::SessionsController
  respond_to :jsonapi
  
  def create
    user = User::CreateSessionService.run(params: user_params)

    if user.valid?
      sign_in(user)
      render jsonapi: user.result, fields: { user: %w(jti) }, status: :accepted #202
    else
      render jsonapi_errors: { detail: user.errors.messages }, status: :not_acceptable #406
    end
  end

  def destroy
    # token = User::DestroySessionService.run()
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      decoded_token = JwtAuth.decode(token)
      user_id = decoded_token[0]['user_id'] #! check to make sure the id address is right inside the hash
      user = User.find(user_id)
      user.invalidate_all_jwt_tokens
      sign_out(user)
    end
    head :no_content
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :username
    )
  end
end

