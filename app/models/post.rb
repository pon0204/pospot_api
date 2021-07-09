class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  has_one :spot, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_one_attached :eyecatch

  validates :title, presence: true
  validates :title, length: { maximum: 50 }
  validates :caption, presence: true
  validates :caption, length: { maximum: 400 }
  validates :genre, presence: true
  validates :with, presence: true
  
  # 紐づいている画像のURLを取得する
  def image_url
    eyecatch.attached? ? url_for(eyecatch) : nil
  end
  
  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end

end
