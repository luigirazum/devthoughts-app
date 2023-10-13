class PostsController < ApplicationController
  def index
    @user = User.includes(posts: [comments: [:user]]).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
    @post.author = current_user
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    respond_to do |format|
      format.html do
        if @post.save
          # redirect to index
          redirect_to user_posts_path(@post.author), notice: 'Post published successfully'
        else
          # error message
          flash[:alert] = @post.errors.full_messages.first
          redirect_back_or_to(new_post_url(@post))
        end
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
