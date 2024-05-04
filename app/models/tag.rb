class Tag < ApplicationRecord

  validates :name, presence: true, length: { maximum: 10 }, uniqueness: true #10文字以内,一意性

  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags
end
