class Spot < ApplicationRecord
  belongs_to :post
  validates :name, presence: true
  validates :place, presence: true
  validates :place_detail, presence: true
  validates :place_id, presence: true
end
