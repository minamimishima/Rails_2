class Room < ApplicationRecord
  validates :room_name, presence: true
  validates :room_detail, presence: true
  validates :fee, presence: true, length: {minimum:1}
  validates :address, presence: true

  mount_uploader :room_image, ImageUploader
  belongs_to :user
  has_many :reservations, dependent: :destroy

def self.search(word)
  Room.where("room_name LIKE ?", "%" + word + "%").or(Room.where("room_detail LIKE ?", "%" + word + "%"))
end

def self.search_by_area(area)
  Room.where("address LIKE ?", "%" + area + "%")
end

end
