module PostsHelper
  def last_three_posts
    Post.published.ordered.take(3)
  end  
end
