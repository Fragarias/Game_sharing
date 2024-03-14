class Relationship < ApplicationRecord
  #belongs_to :end_user
  # class_name: "EndUser"でEndUserモデルを参照
  belongs_to :followers, class_name: "EndUser"
  belongs_to :followees, class_name: "EndUser"
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'target_id', dependent: :destroy # Notification関連

  # Notification作成
  def create_notification_follow!(current_end_user, end_user_id)
    # 既に通知があるかどうかの判定
    temp = Notification.where(["target_user_id = ? and target_id = ? and target_type = ?", end_user_id, id, 0]) # target_typeは、通知の種別によって変更
    return unless temp.blank? && current_end_user.id != end_user_id

    notification = self.active_notifications.new(
      target_user_id: end_user_id,
      target_id: id,
      target_type: 0,
      sender_user_id: current_end_user.id
    )
    notification.save if notification.valid?
  end
end
