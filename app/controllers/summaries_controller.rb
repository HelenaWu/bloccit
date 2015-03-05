class SummariesController < ApplicationController
  def new
    @summary = Summary.new
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])

  end
  
  def create
    @summary = Summary.new(params.require(:summary).permit(:content))
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @summary.post = @post
    if @summary.save
      redirect_to [@topic, @post, :summary]
    else
      flash[:error] = "Error creating summary."
      render :new
    end
  end

  def show
    @post = Post.find(params[:post_id])
    @summary = Summary.find(@post.summary_id)
    @topic = Topic.find(params[:topic_id])
  end
end
