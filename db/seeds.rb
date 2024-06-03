# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by!(email: ENV['SECRET_EMAIL']) do |admin|
 admin.password = ENV['SECRET_PASS']
end

cosmos = Community.find_or_create_by!(name: "COSMOS") do |community|
  community.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/game_cosmos.jpg"), filename:"game_cosmos.jpg")
  community.overview = "豪華声優陣がおくる幻想的なオープンワールドRPG！"
end

moon = Community.find_or_create_by!(name: "MOON") do |community|
  community.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/game_moon.jpg"), filename:"game_moon.jpg")
  community.overview = "美麗な銀河へ旅立つスペースファンタジー！"
end

haru = EndUser.find_or_create_by!(email: "Haru93@example.com") do |user|
  user.name = "はる"
  user.introduction = "プレイスタイルはゆったり派。"
  user.password = ENV['USER_PASS1']
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_sakura.jpg"), filename:"user_sakura.jpg")
end

gin = EndUser.find_or_create_by!(email: "Gin1705@example.com") do |user|
  user.name = "ジン"
  user.introduction = "19時〜21時にプレイしてます。"
  user.password = ENV['USER_PASS2']
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_dog.jpg"), filename:"user_dog.jpg")
end

nagi = EndUser.find_or_create_by!(email: "Nagi128@example.com") do |user|
  user.name = "なぎ"
  user.introduction = "ゲーム初心者です。"
  user.password = ENV['USER_PASS3']
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_cat.jpg"), filename:"user_cat.jpg")
end

tag1 = Tag.find_or_create_by!(name: "攻略")
tag2 = Tag.find_or_create_by!(name: "雑談")

Post.find_or_create_by!(title: "新情報！") do |post|
  post.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post_tea.jpg"), filename:"post_tea.jpg")
  post.text = "新しく日本モチーフのエリアが公開されるらしい！早速行ってみたい。"
  post.end_user_id = haru.id
  post.community_id = cosmos.id
  post.tag_ids  = [tag2.id]
end

Post.find_or_create_by!(title: "難関ステージ") do |post|
  post.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post_desk.jpg"), filename:"post_desk.jpg")
  post.text = "クリアするのに２週間ぐらいかかった。ステージの仕掛けが特殊だった。"
  post.end_user_id = gin.id
  post.community_id = moon.id
  post.tag_ids  = [tag1.id]
end
