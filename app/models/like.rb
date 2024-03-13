class Like < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'target_id', dependent: :destroy # Notification関連
  validates :end_user_id, uniqueness: {scope: :post_id}

  # Notification作成
  def create_notification_like!(current_end_user, post)
    end_user_id = post.end_user_id
    # 既にいいね通知があるかどうかの判定
    temp = Notification.where(["target_user_id = ? and target_id = ? and target_type = ?", end_user_id, id, 2]) # target_typeは、通知の種別によって変更
    return unless temp.blank? && current_end_user.id != end_user_id

    notification = self.active_notifications.new(
      target_user_id: end_user_id,
      target_id: id,
      target_type: 2,
      sender_user_id: current_end_user.id
    )
    notification.save if notification.valid?
  end

end
