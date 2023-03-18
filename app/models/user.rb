require 'uri'
class User < ApplicationRecord

  PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: { case_sensitive: false },
            allow_blank: false, length: { maximum: 70 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP, massege: 'invalid format'}
  validates :jti, uniqueness: { case_sensitive: true }, allow_nil: true

  after_create :generate_jwt
 
  def generate_jwt
    self.jti = JwtAuth.encode({ email: self.email })
  end
end
