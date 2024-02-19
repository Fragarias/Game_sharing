class Post < ApplicationRecord
  belongs_to :end_user
  belongs_to :community
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_one_attached :post_image
end
