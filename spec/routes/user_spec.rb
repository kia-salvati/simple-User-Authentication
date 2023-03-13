require 'rails_helper'

RSpec.describe ApplicationController, type: :routing do
  it 'Create user' do
    expect(post: "/api/signup").to route_to(controller: 'registrations', action: 'create')
  end

  it 'Create jwt token' do
    expect(post: "/api/login").to route_to(controller: 'session', action: 'create')
  end

  it 'Delete jwt token' do 
    expect(delete: '/api/sign_out').to route_to(controller: 'session', action: 'destroy')
  end
end