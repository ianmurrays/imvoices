class User < ActiveRecord::Base
  has_secure_password

  validates :password, presence: true, on: :create
  validates :email, uniqueness: true, presence: true, on: :create
end
