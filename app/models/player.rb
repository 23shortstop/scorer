class Player < ActiveRecord::Base
  validates :name, presence: true
  validates :number, presence: true
  validates :number, inclusion: { in: 0..99 }

  mount_uploader :photo, ImageUploader

  belongs_to :team

end
