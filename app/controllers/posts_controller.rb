class PostsController < ApplicationController
  def index
    @posts = Post.all
    authorize @posts
  end

  def show
    @post = Post.find(params[:id])
    @topic = @post.topic

    @comment = Comment.new #if policy(@comment).new?  error: unable to find policy for nil class
    authorize @comment, :new?
    @comments = @post.comments

  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def create
#    @post = Post.new(params.require(:post).permit(:title, :body))
    #now create user-specific posts
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post
    
    if @post.save
      @post.create_vote
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else      
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])    
    @post = Post.find(params[:id])
    authorize @post
  end
  
  def update
    @topic = Topic.find(params[:topic_id])    
    @post = Post.find(params[:id])
    
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    title = @post.title
    authorize @post
    if @post.destroy
      flash[:notice] = "\"#{title}\" was destroyed succesfully."
      redirect_to @topic
    else
      flash[:error] = "There was a error deleting the post."
      render :show
    end
  end
  
  private 
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
