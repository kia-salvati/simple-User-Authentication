require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do
  describe '#Destroy' do
    context 'valid token' do
      it 'deprecate the token' do 
        user = create(:user)

        user.jti = user.generate_jwt
        user.save
        binding.pry
        delete '/api/logout'
      end
    end
  end
end