class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @current_user = current_user
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  def create
    post = Post.new(params.require(:post).permit(:title, :text))
    post.author = current_user
    respond_to do |format|
      format.html do
        if post.save
          # success message
          flash[:success] = 'Post published successfully'
          # redirect to index
          redirect_to user_posts_path
        else
          # error message
          flash.now[:error] = 'Error: Post could not be published'
          # render new
          render :new, locals: { post: }
        end
      end
    end
  end
end
