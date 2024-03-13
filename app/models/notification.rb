class Notification < ApplicationRecord

  default_scope -> { order(created_at: :desc) }
  # # belongs_to :end_user
  belongs_to :end_user, class_name: "EndUser", foreign_key: "sender_user_id"
  # #belongs_to :relationship
  belongs_to :relationship, class_name: "Relationship", foreign_key: "target_id", optional: true
  # # belongs_to :comment
  belongs_to :comment, class_name: "Comment", foreign_key: "target_id", optional: true
  # # belongs_to :like
  belongs_to :like, class_name: "Like", foreign_key: "target_id", optional: true


  enum target_type: {
    follow: 0,
    comment: 1,
    like: 2
  }
end
