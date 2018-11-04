class User < ApplicationRecord
  include Clearance::User
  has_many :shouts, dependent: :destroy
  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout
  has_many :followed_user_relationships,
    foreign_key: :follower_id,
    class_name: "FollowingRelationship",
    dependent: :destroy
  has_many :followed_users, through: :followed_user_relationships
  # allows overriding of typical rails behaviour through fk rather than user id and cn
  has_many :follower_relationships,
    foreign_key: :followed_user_id,
    class_name: "FollowingRelationship",
    dependent: :destroy
  has_many :followers, through: :follower_relationships
  validates :username, presence: true, uniqueness: true

  def like(shout)
    liked_shouts << shout
  end

  def unlike(shout)
    liked_shouts.destroy(shout)
  end

  def liked?(shout)
    liked_shout_ids.include?(shout.id)
  end

  def follow(user)
    followed_users << user
  end

  def unfollow(user)
    followed_users.delete(user)
  end

  def following?(user)
    # comes from has_many relation
    followed_user_ids.include?(user.id)
  end

  def timeline_shouts
    Shout.where(user_id: followed_user_ids + [id])
  end
# overwrites routes to id
  def to_param
    username
  end
end
