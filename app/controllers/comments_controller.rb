class CommentsController < ApplicationController
  def new
    @comment  = Comment.new
  end
  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comments = @post.comments
    @comment = Comment.new(comment_params)

    @comment.post = @post
    if current_user
      @comment.user = current_user
    end
    authorize @comment

    if @comment.save
      flash[:notice] = "comment was saved successfully."
      redirect_to topic_post_url(@topic, @post)
    else      
      flash[:error] = "There was an error saving the comment. Please try again."
      # redirect_to topic_post_url(@topic, @post)
      render "posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @topic = @post.topic    
    @comment = @post.comments.find(params[:id])
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      # redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted, try again."
      # redirect_to [@topic, @post]
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end