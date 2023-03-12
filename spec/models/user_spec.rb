require 'rails_helper'

RSpec.describe User, type: :model do
  
  context 'Validates presence' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  context 'Validates Uniqueness' do
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:jti) }
  end

  context 'Create User in date base' do
    it 'with valide input' do
      user = FactoryBot.attributes_for(:user)

      expect(User.create(user)).to be_valid
    end
  end

  context "Can't a create user" do
    it 'when username is blank' do
      expect { user = create(:user, username: '') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context '#jwt_token' do
    it 'generates a JWT token for the user through JwtAuth class' do
      user = create(:user)
      
      expect(JwtAuth.encode(user_id: user.id, expiration: 1.hours.from_now)).to be_present
    end

    it 'generates a JWT token for the user through User model' do
      user = create(:user)
      
      expect(user.generate_jwt).to be_present
    end
  end
end
