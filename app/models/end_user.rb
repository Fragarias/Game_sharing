class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :game_bookmarks, dependent: :destroy
  has_many :notifications

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "followers_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followees_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followees
  has_many :followers, through: :reverse_of_relationships, source: :followers


  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  # フォローしたときの処理
  def follow(end_user_id)
    relationships.find_or_create_by(followees_id: end_user_id)
  end
  # フォローを外すときの処理
  def unfollow(end_user_id)
    relationships.find_by(followees_id: end_user_id).destroy
  end
  # フォローしているか判定
  def following?(current_end_user, end_user)
    followings.include?(end_user)
  end

end
