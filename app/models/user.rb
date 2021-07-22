class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  def follow!(user)
    following_relationships.create!(following_id: user)
  end

  def unfollow!(user)
    relation = following_relationships.find_by!(following_id: user)
    relation.destroy!
  end

  def self.from_token_payload(payload)
    find_by(sub: payload['sub']) || create!(sub: payload['sub'])
  end

  def create_profile(user)
    if user.profile.blank?
      profile = user.build_profile(nickname: "ユーザー#{user['id']}", introduction: '')
      profile.save
    end
  end
end
