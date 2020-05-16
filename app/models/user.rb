class User < ApplicationRecord
  has_many :orders
  has_secure_password
  validates :name, :email, presence: true, uniqueness: { case_sensitive: false }
  validates :address, :phone_no, presence: true
end
