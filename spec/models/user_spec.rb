require 'rails_helper'

describe User do 
  
  describe "#favourited(post)" do
    before do
      @user = create(:user)
      @post_fav = create(:post)
      @post_unfav = create(:post)
      @user.favorites.where(post: @post_fav).create
    end
    
    it "returns `nil` if the user has not favourited the post" do
      expect(@user.favorited(@post_unfav)).to be_nil
    end

    it "returns the appropriate favourite if it exists" do
      expect(@user.favorited(@post_fav)).to eq(@user.favorites.where(post: @post_fav).first)
    end
    
  end


  describe ".top_rated" do
    before do
      @user1 = create( :user_with_post_and_comment)
      @user2 = create( :user_with_post_and_comment, num_comments: 2)
    end

    it "returns users ordered by comments + posts" do
      expect(User.top_rated).to eq([@user2, @user1])
    end

    it "stores a `post_count` on user" do
      users = User.top_rated
      expect(users.first.posts_count).to eq(1)
    end

    it "stores a `comment_count` on user" do
      users = User.top_rated
      expect(users.first.comments_count).to eq(2)
    end
  end
end