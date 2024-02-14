class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :post_id,     null: false                  #投稿ID
      t.integer :end_user_id, null: false                  #コメント主ユーザID
      t.string  :text,        null: false                  #コメント
      t.boolean :is_deleted,  null: false, default: false  #削除ステータス
      t.timestamps
    end
  end
end
