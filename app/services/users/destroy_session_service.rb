module Users
  class DestroySessionService < ActiveInteraction::Base
    attr_reader :user, :params

    def exexute 
      find_user
    end

    private

    def find_user

    end
  end
end