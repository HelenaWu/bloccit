require 'rails_helper'

describe User do 
  include TestFactories
  

  describe "#favourited(post)" do
    before do
      @post_fav = associated_post
      @post_unfav = associated_post
      @user = authenticated_user
      @comment  = Comment.new(body: 'My comment', post: @post, user_id: 10000)
      @user.favorites.where(post: @post_fav).create
    end
    
    it "returns `nil` if the user has not favourited the post" do
      expect(@user.favorited(@post_unfav)).to be_nil
    end

    it "returns the appropriate favourite if it exists" do
      expect(@user.favorited(@post_fav)).to eq(@user.favorites.where(post: @post_fav).first)
    end
    
  end
end