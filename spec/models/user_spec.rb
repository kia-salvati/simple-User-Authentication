require 'rails_helper'

RSpec.describe User, type: :model do
  
  context 'Validates presence' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  context 'Validates Uniqueness' do
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:jti).case_sensitive }
  end

  context 'Create User in date base' do
    it 'with valide input' do
      user = FactoryBot.attributes_for(:user)

      expect(User.create(user)).to be_valid
    end
  end

  context "Can't a create user" do
    it 'when username is blank' do
      usrer = create(:user, username: '')
      
      expect(user.valid?).to be_false
    end
  end

  context '#jwt_token' do
    it 'generates a JWT token for the user' do
      expect(user.generate_jwt).to be_present
    end
  end
end
