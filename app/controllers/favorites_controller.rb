class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite
    if favorite.save
      flash[:notice] = "Post has been favorited."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Post could not be favorited."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.where(post_id: params[:post_id]).first
    authorize favorite
    if favorite.destroy
      flash[:notice] = "Successfully unfavorited."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Post could not be unfavorited."
      redirect_to [@post.topic, @post]
    end
  end
end
