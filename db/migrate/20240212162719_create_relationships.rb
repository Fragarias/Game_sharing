class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false  #フォロー主ユーザID
      t.integer :followee_id, null: false  #フォロー先ユーザID
      t.timestamps
    end
  end
end
