require 'rails_helper'

RSpec.describe Users::CreateSessionService do
  describe '#execute' do
    context 'Valid request' do
      it 'Create a JWT token in database and return the token' do
        user = create(:user, password: '!@#$%^&*')

        params = object_to_params(user)
        
        service_result = described_class.run(params: params)

        expect(service_result.valid?).to be_truthy
        expect(service_result.result.username).to eql(user[:username])
        expect(service_result.result.jti).to be_present
      end
    end

    context 'Invalid request' do
      it 'with a wrong eamil' do
        user = create(:user)

        params = object_to_params(user)
        params[:email] = 'wrong_email'

        service_result = described_class.run(params: params)

        expect(service_result.result.jti).to_not be_present
        expect(service_result.result.errors.messages[:user]).to include("invalid password or email")
        expect(service_result.result.valid?).to be_falsey
      end

      it 'with a wrong password' do
        user = create(:user)

        params = object_to_params(user)
        params[:password] = 'wrong_password'

        service_result = described_class.run(params: params)
        
        expect(service_result.result.jti).to_not be_present
        expect(service_result.result.errors.messages[:user]).to include("invalid password or email")
        expect(service_result.valid?).to be_falsey
      end
    end
  end

  def object_to_params(user)
    params = Hash.new

    params[:email] = user.email
    params[:password] = '!@#$%^&*'
    params[:username] = user.username
    params
  end
end