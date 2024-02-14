class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :target_user_id, null: false                  #通知先ユーザID
      t.integer :target_id,      null: false                  #通知元ID
      t.integer :target_type,    null: false                  #通知元種類[enum使用]
      t.boolean :is_checked,     null: false, default: false  #既読ステータス
      t.timestamps
    end
  end
end
