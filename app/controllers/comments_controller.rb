class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    # for some reason comment_params was not recognized
    @comment = Comment.new(body: params[:comment][:body])
    @comment.post = @post
    if (current_user.present?)
      @comment.user = current_user
    end
    if @comment.save
      flash[:notice] = "comment was saved successfully."
      redirect_to topic_post_url(@topic, @post)
    else      
      flash[:error] = "There was an error saving the comment. Please try again."
      redirect_to topic_post_url(@topic, @post)
    end
  end
end