require 'rails_helper'

RSpec.describe RegistrationsController, type: :request do
  describe "#Create" do
    context 'valid requests' do
      it 'create a new user' do
        attributes = FactoryBot.attributes_for(:user)
        attributes[:password_confirmation] = attributes[:password]
        binding.pry
        post "/api/signup", params: { 
          user: attributes
        }
        json = json_parser
        
        expect { response }.to have_http_status(:created) #201
        expect(json).to include(attributes[:username])
      end
    end
  end

  private

  def json_parser
    JSON.parse(response.body)
  end
end