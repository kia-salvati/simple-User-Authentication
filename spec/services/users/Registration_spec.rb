require 'rails_helper'

RSpec.describe Users::RegistrationService do
  describe '#execute'do
    context 'Valid Inputs' do
      it 'creates a new user' do
        attributes = FactoryBot.attributes_for(:user)

        service_result = described_class.run(params: attributes)

        expect(service_result.valid?).to be_truthy
        expect(service_result.result.encrypted_password).to be_present
        expect(service_result.result.username).to eql(attributes[:username])
      end
    end

    context 'Invalid Inputs' do
      it 'Invalid Attributes blank username' do
        attributes = FactoryBot.attributes_for(:user, username: '')

        service_result = described_class.run(params: attributes)
        
        expect(service_result.valid?).to be_falsey
        expect(service_result.result.username).to eql(attributes[:username])
        expect(service_result.errors.messages[:base]).to eql(["Username can't be blank", "Username is too short (minimum is 1 character)"])
      end

      it 'Invalid Attributes nil email' do
        attributes = FactoryBot.attributes_for(:user, email: nil)

        service_result = described_class.run(params: attributes)

        expect(service_result.valid?).to be_falsey
        expect(service_result.errors.messages[:base]).to eql(["Email can't be blank", "Email is invalid"])
      end
    end
  end
end