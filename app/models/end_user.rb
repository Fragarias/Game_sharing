class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 } #名前 20文字以内
  validates :introduction, length: { maximum: 80 } #自己紹介文 80文字以内
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #emailフォーマット
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  has_many :posts#, dependent: :destroy
  has_many :comments#, dependent: :destroy
  has_many :likes#, dependent: :destroy
  has_many :game_bookmarks#, dependent: :destroy

  # 通知を送られた(通知先)の関係
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'target_id'#, dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "target_user_id"#, dependent: :destroy

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "followers_id"#, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followees_id"#, dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followees
  has_many :followers, through: :reverse_of_relationships, source: :followers

  has_one_attached :profile_image #ActiveStorage_プロフィール画像
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_profile_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest #ゲストログイン用メソッド
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

  # ユーザ退会時のフォロー解除
  def remove_follow(end_user)
    relationships.where(followers_id: end_user.id).destroy_all
    relationships.where(followees_id: end_user.id).destroy_all
  end
  def user_has_many_delete(end_user)
      end_user.posts.update_all(is_deleted: true)
      end_user.comments.update_all(is_deleted: true)
      end_user.likes.destroy_all
      end_user.game_bookmarks.destroy_all
  end

end
