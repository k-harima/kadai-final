class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :items
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favorites
  has_many :likings, through: :favorites, source: :item
  has_many :reviews
  has_many :reviewings, through: :reviews, source: :item

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def favorite(item)
    self.favorites.find_or_create_by(item_id: item.id)
  end

  def unfavorite(item)
    favorite = self.favorites.find_by(item_id: item.id)
    favorite.destroy if favorite
  end

  def liking?(item)
    self.likings.include?(item)
  end
  
  def reviewing?(other_item)
    self.reviewings.include?(other_item)
  end
end
