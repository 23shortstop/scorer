class Session < ActiveRecord::Base
  include ActiveModel::Serialization

  belongs_to :authenticable, polymorphic: true

  attr_reader :authenticable, :token

  def initialize(authenticable, token)
    @authenticable  = authenticable
    @token = token
  end
end
