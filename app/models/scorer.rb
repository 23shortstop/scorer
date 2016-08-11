class Scorer < ActiveRecord::Base
  include TokenAuth::Authenticatable

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :sessions, as: :authenticable
  has_many :games
end
