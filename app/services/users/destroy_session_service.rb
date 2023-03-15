module Users
  class DestroySessionService < ActiveInteraction::Base
    attr_reader :params, :user

    hash :params, strip: false

    def execute
      token_validation

      user
    end

    def token_validation
      if params.key?(:jti)
        token = params[:jti]

        decoded_token = JwtAuth.decode(token)

        unless @user = User.find_by(email: decoded_token['email'])
          errors.add(:base, 'The generated token is incorrect')
          return
        end

        if user.jti.present? && user.jti == token
          user.jti = nil
          user.save
        else
          errors.add(:base, 'Invalid token')
        end
      else
        errors.add(:base, 'Your are not authenticated')
      end
    end
  end
end