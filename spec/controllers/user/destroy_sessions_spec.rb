require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do
  describe '#Destroy' do
    context 'with valid token' do
      it 'deprecate the token' do 
        user = create(:user)

        user.jti = user.generate_jwt
        user.save

        payload = JwtAuth.encode(payload: user, expiration: 5.minutes.from_now)

        delete '/api/logout',
          headers: { 'Authorization': "Bearer #{user.jti}" },
          params: payload
      end
    end
  end
end