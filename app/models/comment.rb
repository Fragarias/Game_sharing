class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'target_id', dependent: :destroy # Notification関連
  after_update :delete_notification

  # Notification作成
  def create_notification_comment!(current_end_user, post)
    end_user_id = post.end_user_id
    # 既に通知があるかどうかの判定
    temp = Notification.where(["target_user_id = ? and target_id = ? and target_type = ?", end_user_id, id, 1]) # target_typeは、通知の種別によって変更
    return unless temp.blank? && current_end_user.id != end_user_id

    notification = self.active_notifications.new(
      target_user_id: end_user_id,
      target_id: id,
      target_type: 1,
      sender_user_id: current_end_user.id
    )
    notification.save if notification.valid?
  end

  def delete_notification
    notification = Notification.find_by(["target_id = ? and target_type = ?", id, 1])
    notification.destroy
  end
end
