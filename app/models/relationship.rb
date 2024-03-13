class Relationship < ApplicationRecord
  #belongs_to :end_user
  # class_name: "EndUser"でEndUserモデルを参照
  belongs_to :followers, class_name: "EndUser"
  belongs_to :followees, class_name: "EndUser"
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'target_id', dependent: :destroy
end
