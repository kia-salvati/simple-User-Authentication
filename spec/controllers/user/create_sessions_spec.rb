require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do
  describe "#Create" do
    context 'valid input' do
      it 'create a new session with a  valid jwt token' do
        user = create(:user, password: '!@#$%^&*')

        params = object_attributes(user)

        post '/api/login', params: {
          user: params
        }

        json = json_parser

        expect(json['data']['attributes']['jti']).to be_present
        expect(json['data']['attributes']['username']).to_not be_present
        expect(json['data']['attributes']['email']).to_not be_present
      end
    end

    context 'invalid input' do
      it 'with a wrong password' do
        user = create(:user)

        params = object_attributes(user)
        params[:password] = 'wrong password'

        post '/api/login', params: {
          user: params
        }

        json = json_parser

        expect(json['errors'][0]['detail']['base']).to include("invalid password or email")
      end

      it 'with a wrong email' do
        user = create(:user)

        params = object_attributes(user)
        params[:email] = 'wrong email'

        post '/api/login', params: {
          user: params
        }

        json = json_parser

        expect(json['errors'][0]['detail']['base']).to include("invalid password or email")
      end
    end
  end
  private 

  def json_parser
    JSON.parse(response.body)
  end

  def object_attributes(user)
    params = Hash.new

    params[:email] = user.email
    params[:password] = '!@#$%^&*'
    params[:username] = user.username
    params
  end
end
