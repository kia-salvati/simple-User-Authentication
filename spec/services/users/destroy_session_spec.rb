require 'rails_helper'

RSpec.describe Users::DestroySessionService do
  describe '#Destroy' do
    context 'Valid jtw token' do
      it 'should destroy the jwt token' do
        user = create(:user)
        user.jti = user.generate_jwt
        user.save

        params = { jti: user.jti }
        
        service_result = described_class.run(params: params)
        
        expect(service_result.valid?).to be_truthy
        expect(service_result.result.jti).to be_nil
      end
    end
    context 'Invalid jtw token' do
      it 'should not accept the jwt token' do
        user = create(:user)
        user.jti = user.generate_jwt
        user.save

        params = { jti: "eyJhbGciOiJIUzI1NiJ9.eyJpZCIferfgrg4OTc4NzA0fQ.mOGCP0EkJId80uUjvcm756s55p4Q4BwjjD8R_W-SsrQ"}
        
        expect { service_result = described_class.run(params: params) }.to raise_error(JWT::VerificationError)
      end

      it 'should reject the jwt token with wrong encoded email' do
        user = create(:user)
       
        user.jti = user.generate_jwt
        user.save

        invalid_token = JwtAuth.encode(email: "wrong@email.com")
        params = { jti: invalid_token }
        
        service_result = described_class.run(params: params)

        expect(service_result.valid?).to be_falsey
        expect(service_result.result).to be_nil
      end

      it 'should reject the jwt token if the token is not saved in database' do
        user = create(:user)
       
        user.jti = user.generate_jwt
        user.save

        params = { jti: user.jti }

        user.jti = nil
        user.save

        service_result = described_class.run(params: params)

        expect(service_result.valid?).to be_falsey
        expect(service_result.errors.messages[:base]).to include("Invalid token")
      end
    end
  end
end