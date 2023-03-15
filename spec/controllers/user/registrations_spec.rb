require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :request do
  describe "#Create" do
    context 'valid requests' do
      it 'create a new user' do
        attributes = FactoryBot.attributes_for(:user)
        
        payload = JwtAuth.encode(payload: attributes, expiration: 5.minutes.from_now)
        
        post "/api/signup", params: {
          user: payload
        }
        
        json = json_parser
        
        expect(response.status).to eql(201) # created
        expect(json["data"]["attributes"]["email"]).to include(attributes[:email])
        expect(json["data"]["attributes"]["jti"]).to be_present
      end
    end
    
    context 'Invalid requests' do
      it 'wiht a blank username' do
        attributes = FactoryBot.attributes_for(:user, username: '')

        payload = JwtAuth.encode(payload: attributes, expiration: 5.minutes.from_now)

        post "/api/signup", params: {
          user: payload
        }

        json = json_parser
        
        expect(response.status).to eql(406) # not_acceptable
        expect(json["errors"][0]["detail"]["base"]).to eql(["Username can't be blank", "Username is too short (minimum is 1 character)"])
      end

      it 'with a nil email' do
        attributes = FactoryBot.attributes_for(:user, email: nil)

        payload = JwtAuth.encode(payload: attributes, expiration: 5.minutes.from_now)

        post "/api/signup", params: {
          user: payload
        }
        
        json = json_parser

        expect(response.status).to eql(406) # not_acceptable
        expect(json["errors"][0]["detail"]["base"]).to eql(["Email can't be blank", "Email is invalid"])
      end
    end
  end

  private

  def json_parser
    JSON.parse(response.body)
  end
end