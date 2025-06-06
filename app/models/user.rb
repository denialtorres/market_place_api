class User < ApplicationRecord
  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :password_digest, presence: true

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_secure_password
end
