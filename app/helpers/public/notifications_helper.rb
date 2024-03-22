module Public::NotificationsHelper

   def notification_form(notification)
	  @end_user = notification.end_user
	  @comment = nil
	  your_item = link_to 'あなたの投稿', post_path(notification), style:"font-weight: bold;"
	  #notification.actionがfollowかlikeかcommentか
	  case notification.target_type
	    when "follow" then
	     # tag.a(notification.end_user.name, href:end_user_path(@end_user), style:"font-weight: bold;")+
	      "あなたをフォローしました"
	    when "like" then
	     # tag.a(notification.end_user.name, href:end_user_path(@end_user), style:"font-weight: bold;")+"さんが"+tag.a('あなたの投稿', href:post_path(notification.like.post), style:"font-weight: bold;")+"にいいねしました"
	      tag.a("あなたの投稿「#{notification.like.post.title}」", href:post_path(notification.like.post), style:"font-weight: bold;")+"にいいねしました"

	    when "comment" then
	    	# tag.a(notification.end_user.name, href:end_user_path(@end_user), style:"font-weight: bold;")+"さんが"+tag.a('あなたの投稿', href:post_path(notification.comment.post), style:"font-weight: bold;")+"にコメントしました"
	    	tag.a("あなたの投稿「#{notification.comment.post.title}」", href:post_path(notification.comment.post), style:"font-weight: bold;")+"にコメントしました"
	  end
	end

end
