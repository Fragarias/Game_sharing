class CreateCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :communities do |t|
      t.string :name, 　　null: false  #ゲーム名
      t.string :overview, null: false  #ゲーム概要
      t.timestamps
    end
  end
end
