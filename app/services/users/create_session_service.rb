module Users
  class CreateSessionService < ActiveInteraction::Base
    attr_reader :user, :params

    hash :params, strip: false

    def execute
      find_user
      
      user
    end

    private
   
    def find_user
      
      @user = User.find_by(email: params[:email])

      if user.present?
        if user.valid_password?(params[:password])
          user.jti = user.generate_jwt
        else
          @user = User.new
          user.errors.add(:user, "invalid password or email")
        end
      else
        @user = User.new
        user.errors.add(:user, "invalid password or email")
      end
    end
  end
end