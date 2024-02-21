class Post < ApplicationRecord
  belongs_to :end_user
  belongs_to :community
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_one_attached :post_image

  def get_post_image(width, height)
    #if post_image.attached?
      post_image.variant(resize_to_limit: [width, height]).processed
    #end
  end
  # def get_post_image(width, height)
  #   unless post_image.attached?
  #     file_path = Rails.root.join('app/assets/images/no_image.jpg')
  #     post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   post_image.variant(resize_to_limit: [width, height]).processed
  # end
end
