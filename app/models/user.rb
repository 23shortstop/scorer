class User < ActiveRecord::Base
  include TokenAuth::Authenticatable

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  credentials :email, :password
end
