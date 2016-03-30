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
      redirect_to posts_path, notice: "新增貼文成功"
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.all
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

  private

  def post_params
    params.require(:post).permit(:title, :link, :description, photo_attributes: [:image, :id])
  end

end
