class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  validates :score, presence: true, numericality: {
                                      less_than_or_equal_to: 5,
                                      greater_than_or_equal_to: 1,
                                    }
  validates :title, presence: true, length: { maximum: 20 }
  validates :text, presence: true, length: { maximum: 500 }
end
