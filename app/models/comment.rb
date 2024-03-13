class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'target_id', dependent: :destroy
end
