module CommentsHelper
  def render_comments_count(post)
    post.comments.size
  end
end
