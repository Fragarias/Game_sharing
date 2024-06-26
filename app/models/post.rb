class Post < ApplicationRecord
  belongs_to :end_user
  belongs_to :community
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, presence: true, length: { maximum: 20 }, on: :publicize
  validates :text, presence: true, length: { maximum: 200 }, on: :publicize

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :like_count, -> { includes(:likes).sort {|a,b| b.likes.size <=> a.likes.size} }
  scope :random, -> { shuffle }

  def liked_by?(end_user)
    likes.exists?(end_user_id: end_user.id)
  end

  has_one_attached :post_image

  def get_post_image(width, height)
    post_image.variant(resize_to_limit: [width, height]).processed
  end
end
