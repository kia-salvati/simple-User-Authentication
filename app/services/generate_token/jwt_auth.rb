require 'jwt'

module GenerateToken
  class JwtAuth
    def self.encode(payload, expiration = 24.hours.from_now)
      payload[:exp] = expiration.to_i
      JWT.encode(
        payload,
        Rails.application.secrets.secret_key_base)
    end

    def self.decode(token)
      JWT.decode(
        token, 
        Rails.application.secrets.secret_key_base, 
        true).first
    end
  end
end