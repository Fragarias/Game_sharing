class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      # references...他テーブルとの関連付け、foreign_key...外部キー制約、（end_usersテーブル参照）
      t.references :followers, foreign_key: { to_table: :end_users } #フォロー主ユーザID
      t.references :followees, foreign_key: true #フォロー先ユーザID
      t.timestamps
    end
  end
end
