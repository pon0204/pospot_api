class Profile < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_one_attached :avatar
  validates :nickname, length: { maximum: 50 }
  validates :introduction, length: { maximum: 200 }

  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end
end
