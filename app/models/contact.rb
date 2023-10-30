class Contact < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { minimum: 6 }
  validates :last_name, presence: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

end
