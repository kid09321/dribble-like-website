class CommentsController < ApplicationController
  before_action :find_post
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to post_path(@post)
    else
      render "new"
    end
  end


    private

    def find_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:context)
    end
end
