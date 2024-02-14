class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.integer :post_id, null: false  #投稿ID
      t.integer :tag_id,  null: false  #タグID
      t.timestamps
    end
  end
end
