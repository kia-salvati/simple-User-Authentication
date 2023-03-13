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

      user.valid_password?(params[:password])
        
      user.jti = user.generate_jwt if user.valid?

      errors.merge!(user.errors) if user.errors.present?
    end
  end
end