# THIS IS A USER
class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates_uniqueness_of :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                                  case_sensitive: false
  validates_length_of :email, maximum: 255

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end