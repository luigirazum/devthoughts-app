class CommentsController < ApplicationController
  def new
    @current_user = current_user
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      # success message
      redirect_to user_post_url(@post.author, @post), notice: 'Comment published successfully.'
    else
      flash.now[:error] = 'Error: Comment could not be published'
      redirect_to user_post_url(@post.author, @post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
