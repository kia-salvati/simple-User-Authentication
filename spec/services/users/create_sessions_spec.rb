require 'rails_helper'

RSpec.describe Users::CreateSessionService do
  describe '#execute' do
    context 'create a new session' do
      it 'finding the valid user' do
        attributes = FactoryBot.attributes_for(:user)
        
        user = User.create(attributes)
       
        binding.pry
        service_result = described_class.run(params: attributes)
       
        expect(service_result.valid?).to be_truthy
        expect(service_result.result.username).to eql(user[:username])
        expect(service_result.result.jti).to be_present
      end
    end
  end
end