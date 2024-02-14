class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :post_id,     null: false  #投稿ID
      t.integer :end_user_id, null: false  #いいね主ユーザID
      t.timestamps
    end
  end
end
