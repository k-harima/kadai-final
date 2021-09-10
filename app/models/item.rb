class Item < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :company, presence: true, length: { maximum: 50 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 },
                                    format: { with: /\A[0-9]+\z/ }
  
  has_many :favorites
  has_many :likers, through: :favorites, source: :user
end
