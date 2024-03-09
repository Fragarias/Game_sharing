class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :game_bookmarks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :relationships#, dependent: :destroy

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

  # フォロー済みの場合...ユーザ、未フォローの場合...nil
  def following?(current_end_user, follower_id)
    Relationship.find_by(followees_id: follower_id, followers_id: current_end_user.id)
  end

  def followed(end_user)
    Relationship.where(followers_id: end_user.id) #end_userがフォローしている
  end

  def follower(current_end_user)
    Relationship.where(followees_id: current_end_user.id) #Log_inユーザをフォローしている
  end

end
