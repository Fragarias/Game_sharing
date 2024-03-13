class AddSenderUserIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :sender_user_id, :integer, null: false  #通知を送ったユーザID
  end
end
