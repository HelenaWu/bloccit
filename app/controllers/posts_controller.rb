class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
#    @post = Post.new(params.require(:post).permit(:title, :body))
    #now create user-specific posts
    @post = current_user.posts.build(params.require(:post).permit(:title, :body))
    # @post2 = Post.new(params.require(:post2).permit(:title, :body))
    # @post3 = Post.new(title: params[:post][:title], body: params[:post][:body])
    # @post.save
    # @post2.save

    # if @post.persisted? && @post2.persisted?
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
    else      
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
end
