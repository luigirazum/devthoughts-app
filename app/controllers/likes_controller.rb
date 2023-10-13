class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    if @like.save
      flash[:notice] = "#{@post.author.name} says thank's for your Like."
    else
      flash[:alert] = "It seems that you've already liked the post."
    end
    redirect_back(fallback_location: user_post_path(@post.author, @post))
  end
end
