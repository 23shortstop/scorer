class Player < ActiveRecord::Base
  validates :name, presence: true
  validates :number, presence: true
  validates_inclusion_of :number, :in => 0..99
  
  belongs_to :team
end