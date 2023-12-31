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
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    post = Post.new(post_params)
    post.author = current_user
    respond_to do |format|
      format.html do
        if post.save
          # redirect to index
          redirect_to user_posts_path(post.author), notice: 'Post published successfully'
        else
          # error message
          flash[:alert] = 'Error: Post could not be published'
          # render new
          render :new, locals: { post: @post }
        end
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
