class SessionsController < Devise::SessionsController
  respond_to :jsonapi
  def create 
    user = User.find_for_database_authintication(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      sign_in(user)
      token = user.generate_jwt
      render json: { token: token }
    else 
      render json: { error: 'Invalid email or password' }, status: :unauthorized #401
    end
  end

  def destroy
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      #* decodeed_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      decoded_token = JwtAuth.decode(token)
      user_id = decoded_token[0]['user_id'] #! check to make sure the id address is right inside the hash
      user = User.find(user_id)
      user.invalidate_all_jwt_tokens
      sign_out(user)
    end
    head :no_content
  end
end

