class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :end_user_id,  null: false                  #ユーザID
      t.integer :community_id, null: false                  #ゲームコミュニティID
      t.string  :title,        null: false                  #題名
      t.text    :text,         null: false                  #本文
      t.boolean :is_published, null: false, default: true   #公開ステータス
      t.boolean :is_deleted,   null: false, default: false  #削除ステータス
      t.timestamps
    end
  end
end
