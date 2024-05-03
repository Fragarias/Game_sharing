class Community < ApplicationRecord

  validates :name, presence: true, length: { maximum: 20 } #20文字以内
  validates :overview, presence: true, length: { maximum: 50 } #50文字以内

  has_many :posts, dependent: :destroy
  has_many :game_bookmarks, dependent: :destroy

  def game_bookmarked_by?(end_user)
    game_bookmarks.exists?(end_user_id: end_user.id)
  end

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
