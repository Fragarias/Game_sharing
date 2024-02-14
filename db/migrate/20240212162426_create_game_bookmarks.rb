class CreateGameBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :game_bookmarks do |t|
      t.integer :community_id, null: false  #ゲームコミュニティID
      t.integer :end_user_id,  null: false  #ユーザID
      t.timestamps
    end
  end
end
