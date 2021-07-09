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
    user_id = get_user_id(user)
    following_relationships.create!(following_id: user_id)
  end

  def unfollow!(user)
    user_id = get_user_id(user)    
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end

  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end
  
  def self.from_token_payload(payload)    
    find_by(sub: payload['sub']) || create!(sub: payload['sub'])
    # Profile.create!(name: payload['name'])
  end

  def self.profile_create_payload(payload)
    user = User.find_by(sub: payload['sub']) 
    if(user.profile.blank?)
    profile = user.build_profile(nickname: "ユーザー#{user['id']}",introduction: '')
    profile.save
    end
  end

  private
  def get_user_id(user)
    if user.is_a?(User)
      user.id
    else
      user
    end
  end
end

