class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :room_name, presence: true
  validates :room_detail, presence: true
  validates :fee, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :address, presence: true

  mount_uploader :room_image, ImageUploader

def self.search(word)
  Room.where("room_name LIKE ?", "%" + word + "%").or(Room.where("room_detail LIKE ?", "%" + word + "%"))
end

def self.search_by_area(area)
  Room.where("address LIKE ?", "%" + area + "%")
end

end
