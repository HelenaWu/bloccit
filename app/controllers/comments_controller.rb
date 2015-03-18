class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
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

  def destroy
    @post = Post.find(params[:post_id])
    @topic = @post.topic    
    @comment = @post.comments.find(params[:id])
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted, try again."
      redirect_to [@topic, @post]
    end
  end
end