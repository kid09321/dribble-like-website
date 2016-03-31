class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
    @photo = @post.build_photo
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      if @post.photo.present?
        redirect_to posts_path, notice: "新增貼文成功"
      else
        render "new"
      end
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @random_post = Post.where.not(id: @post).order("RANDOM()").first
  end

  def edit
    @post = current_user.posts.find(params[:id])
    @photo = @post.photo || @post.build_photo

  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:warning] = "編輯成功"
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end


  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_user
    redirect_to post_path(@post)
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user
    redirect_to post_path(@post)
  end
  private

  def post_params
    params.require(:post).permit(:title, :link, :description, photo_attributes: [:image, :id])
  end

end
