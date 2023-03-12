module Users
  class RegistrationService< ActiveInteraction::Base
    attr_reader :params, :user

    hash :params, strip: false

    def execute 
      create_user

      user
    end

    def create_user
      @user = User.new
      user.username = params[:username] if params.key?(:username)
      user.email = params[:email] if params.key?(:email)
      user.password = params[:password] if params.key?(:password)

      user.save
      
      errors.merge!(user.errors) if user.errors.present?
    end
  end
end