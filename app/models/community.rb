class Community < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :game_bookmarks, dependent: :destroy
  has_one_attached :image
end
