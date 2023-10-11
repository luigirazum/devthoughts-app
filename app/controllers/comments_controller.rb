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
      redirect_to user_post_path(@post.author, @post), notice: 'Comment published successfully.'
    else
      flash[:alert] = 'Error: Comment could not be published'
      render :new, locals: { comment: @comment }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
