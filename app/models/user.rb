class User < ApplicationRecord

  has_secure_password
  validates :name, presence: true, length:  { minimum: 6 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length:  { minimum: 6 }
  validates_confirmation_of :password
  validates_confirmation_of :password_confirmation

end
