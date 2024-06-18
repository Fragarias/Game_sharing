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

_cosmos = Community.find_or_create_by!(name: "COSMOS") do |community1|
  community1.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/game_cosmos.jpg"), filename:"game_cosmos.jpg")
  community1.overview = "豪華声優陣がおくる幻想的なオープンワールドRPG！"
end

_moon = Community.find_or_create_by!(name: "MOON") do |community2|
  community2.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/game_moon.jpg"), filename:"game_moon.jpg")
  community2.overview = "美麗な銀河へ旅立つスペースファンタジー！"
end

_cookie = Community.find_or_create_by!(name: "COOKIE") do |community3|
  community3.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/game_cookie.jpg"), filename:"game_cookie.jpg")
  community3.overview = "ざくざく爽快！新感覚パズルゲーム"
end

_fruit= Community.find_or_create_by!(name: "FRUIT") do |community4|
  community4.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/game_fruit.jpg"), filename:"game_fruit.jpg")
  community4.overview = "至上の果実を奪い合うアクションシューティング！"
end


_haru = EndUser.find_or_create_by!(email: "Haru93@example.com") do |user1|
  user1.name = "はる"
  user1.introduction = "プレイスタイルはゆったり派。"
  user1.password = ENV['USER_PASS1']
  user1.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_sakura.jpg"), filename:"user_sakura.jpg")
end

_gin = EndUser.find_or_create_by!(email: "Gin1705@example.com") do |user2|
  user2.name = "ジン"
  user2.introduction = "19時〜21時にプレイしてます。"
  user2.password = ENV['USER_PASS2']
  user2.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_dog.jpg"), filename:"user_dog.jpg")
end

_nagi = EndUser.find_or_create_by!(email: "Nagi128@example.com") do |user3|
  user3.name = "なぎ"
  user3.introduction = "ゲーム初心者です。"
  user3.password = ENV['USER_PASS3']
  user3.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_cat.jpg"), filename:"user_cat.jpg")
end

_yuu = EndUser.find_or_create_by!(email: "Yu_1819@example.com") do |user4|
  user4.name = "ユウ"
  user4.introduction = "ただいまフレンド募集中"
  user4.password = ENV['USER_PASS4']
  user4.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_light.jpg"), filename:"user_light.jpg")
end

_taku = EndUser.find_or_create_by!(email: "Taku4259@example.com") do |user5|
  user5.name = "たく"
  user5.introduction = "おすすめのシューティングゲームあったら教えて！"
  user5.password = ENV['USER_PASS5']
  user5.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user_taxi.jpg"), filename:"user_taxi.jpg")
end

_tag1 = Tag.find_or_create_by!(name: "攻略")
_tag2 = Tag.find_or_create_by!(name: "雑談")
_tag3 = Tag.find_or_create_by!(name: "募集")

_post1 = Post.find_or_create_by!(title: "新情報！") do |post1|
  post1.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post_snow.jpg"), filename:"post_snow.jpg")
  post1.text = "新しく日本モチーフのエリアが公開されるらしい！早速行ってみたい。"
  post1.end_user_id = _haru.id
  post1.community_id = _cosmos.id
  post1.tag_ids  = [_tag2.id]
end

_post2 = Post.find_or_create_by!(title: "難関ステージ") do |post2|
  post2.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post_desk.jpg"), filename:"post_desk.jpg")
  post2.text = "クリアするのに２週間ぐらいかかった。ステージの仕掛けが特殊だった。"
  post2.end_user_id = _gin.id
  post2.community_id = _moon.id
  post2.tag_ids  = [_tag1.id]
end

_post3 = Post.find_or_create_by!(title: "マルチ募集〜") do |post3|
  post3.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post_berry.jpg"), filename:"post_berry.jpg")
  post3.text = "このステージ誰か一緒にマルチしない？コメント待ってます！"
  post3.end_user_id = _taku.id
  post3.community_id = _fruit.id
  post3.tag_ids  = [_tag3.id]
end

_post4 = Post.find_or_create_by!(title: "フレ募集投稿") do |post4|
  post4.text = "フレンド募集中！ゲームもいろんな種類プレイしたいので、おすすめ教えてください！"
  post4.end_user_id = _yuu.id
  post4.community_id = _moon.id
  post4.tag_ids  = [_tag2.id, _tag3.id]
end

_post5 = Post.find_or_create_by!(title: "共有したい") do |post5|
  post5.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post_tea.jpg"), filename:"post_tea.jpg")
  post5.text = "今のイベント新鮮で楽し〜！みんなもやって、感想聞かせて！あとだるまクッキー使うとうまくいく！"
  post5.end_user_id = _haru.id
  post5.community_id = _cookie.id
  post5.tag_ids  = [_tag1.id, _tag2.id]
end

_post6 = Post.find_or_create_by!(title: "気になってる") do |post6|
  post6.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post_book.jpg"), filename:"post_book.jpg")
  post6.text = "fruit見た目が好きではじめてみようか迷ってる。fruitプレイしてる人いる？"
  post6.end_user_id = _haru.id
  post6.community_id = _fruit.id
  post6.tag_ids  = [_tag2.id]
end

Like.find_or_create_by!(post_id: _post1.id, end_user_id: _yuu.id)
Comment.find_or_create_by!(post_id: _post1.id, end_user_id: _gin.id, text: "おー！ここまで進んだんだ！はやいね！")
Comment.find_or_create_by!(post_id: _post1.id, end_user_id: _yuu.id, text: "初めまして！このエリア綺麗ですよね。もしよければはるさんとフレンドになりたいです！")

Like.find_or_create_by!(post_id: _post2.id, end_user_id: _haru.id)
Like.find_or_create_by!(post_id: _post2.id, end_user_id: _nagi.id)
Like.find_or_create_by!(post_id: _post2.id, end_user_id: _taku.id)
Comment.find_or_create_by!(post_id: _post2.id, end_user_id: _nagi.id, text: "第五ステージのマップ右端にあるギミックが解けなくて困ってます...")

Like.find_or_create_by!(post_id: _post3.id, end_user_id: _gin.id)
Like.find_or_create_by!(post_id: _post3.id, end_user_id: _yuu.id)
Comment.find_or_create_by!(post_id: _post3.id, end_user_id: _gin.id, text: "一緒にマルチしましょう")

Like.find_or_create_by!(post_id: _post4.id, end_user_id: _nagi.id)
Comment.find_or_create_by!(post_id: _post4.id, end_user_id: _gin.id, text: "俺でよければフレンドなりましょ〜")
Comment.find_or_create_by!(post_id: _post4.id, end_user_id: _nagi.id, text: "初心者ですがお友達になりたいです！")

Like.find_or_create_by!(post_id: _post5.id, end_user_id: _taku.id)
_like1 = Like.find_or_create_by!(post_id: _post5.id, end_user_id: _nagi.id)
Comment.find_or_create_by!(post_id: _post5.id, end_user_id: _taku.id, text: "このゲーム気になってた！どんなゲームなの？")
_comment1 = Comment.find_or_create_by!(post_id: _post5.id, end_user_id: _nagi.id, text: "えっ！そんな方法が...")
Notification.find_or_create_by!(target_user_id: _haru.id, sender_user_id: _nagi.id, target_id: _like1.id, target_type: 2)
Notification.find_or_create_by!(target_user_id: _haru.id, sender_user_id: _nagi.id, target_id: _comment1.id, target_type: 1)

_like2 = Like.find_or_create_by!(post_id: _post6.id, end_user_id: _gin.id)
_like3 = Like.find_or_create_by!(post_id: _post6.id, end_user_id: _nagi.id)
_like4 = Like.find_or_create_by!(post_id: _post6.id, end_user_id: _yuu.id)
_like5 = Like.find_or_create_by!(post_id: _post6.id, end_user_id: _taku.id)
_comment2 = Comment.find_or_create_by!(post_id: _post6.id, end_user_id: _taku.id, text: "僕はかなりやりこんでるけど飽きない！楽しいよ！")
Notification.find_or_create_by!(target_user_id: _haru.id, sender_user_id: _gin.id, target_id: _like2.id, target_type: 2)
Notification.find_or_create_by!(target_user_id: _haru.id, sender_user_id: _taku.id, target_id: _comment2.id, target_type: 1)
Notification.find_or_create_by!(target_user_id: _haru.id, sender_user_id: _yuu.id, target_id: _like4.id, target_type: 2)
Notification.find_or_create_by!(target_user_id: _haru.id, sender_user_id: _taku.id, target_id: _like5.id, target_type: 2)

GameBookmark.find_or_create_by!(community_id: _cosmos.id, end_user_id: _haru.id)
GameBookmark.find_or_create_by!(community_id: _cosmos.id, end_user_id: _yuu.id)

GameBookmark.find_or_create_by!(community_id: _moon.id, end_user_id: _gin.id)
GameBookmark.find_or_create_by!(community_id: _moon.id, end_user_id: _nagi.id)
GameBookmark.find_or_create_by!(community_id: _moon.id, end_user_id: _yuu.id)

GameBookmark.find_or_create_by!(community_id: _cookie.id, end_user_id: _haru.id)
GameBookmark.find_or_create_by!(community_id: _cookie.id, end_user_id: _nagi.id)

GameBookmark.find_or_create_by!(community_id: _fruit.id, end_user_id: _haru.id)
GameBookmark.find_or_create_by!(community_id: _fruit.id, end_user_id: _gin.id)
GameBookmark.find_or_create_by!(community_id: _fruit.id, end_user_id: _taku.id)

Relationship.find_or_create_by!(followers_id: _haru.id, followees_id: _gin.id)
Relationship.find_or_create_by!(followers_id: _haru.id, followees_id: _yuu.id)
Relationship.find_or_create_by!(followers_id: _gin.id, followees_id: _haru.id)
Relationship.find_or_create_by!(followers_id: _gin.id, followees_id: _taku.id)
Relationship.find_or_create_by!(followers_id: _nagi.id, followees_id: _gin.id)
Relationship.find_or_create_by!(followers_id: _yuu.id, followees_id: _haru.id)
Relationship.find_or_create_by!(followers_id: _taku.id, followees_id: _gin.id)
Relationship.find_or_create_by!(followers_id: _taku.id, followees_id: _yuu.id)
_follow = Relationship.find_or_create_by!(followers_id: _taku.id, followees_id: _haru.id)
Notification.find_or_create_by!(target_user_id: _haru.id, sender_user_id: _taku.id, target_id: _follow.id, target_type: 0)